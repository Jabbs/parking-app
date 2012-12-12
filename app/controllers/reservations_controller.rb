class ReservationsController < ApplicationController
  
  def show
    @reservation = Reservation.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReservationPdf.new(@reservation, view_context)
        send_data pdf.render, filename: "reservation_#{@reservation.confirmation_number}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end
  
  def create
    if Cart.find_by_id(session[:cart_id])
      @cart = Cart.find_by_id(session[:cart_id])
    else
      @cart = Cart.create!
      session[:cart_id] = @cart.id
    end
    search = Search.find_by_id(params[:search_id])
    rh_id_group = params[:rh_group]
    @x = 0
    Reservation.where(cart_id: @cart.id).each do |reservation|
      reservation.rent_hours.each do |rh|
        rh_id_group.each do |rh_id|
          if rh.id == rh_id.to_i
            @x = 1
          end
        end
      end
    end
    if @x == 1
      redirect_to search_path(search), alert: "Cannot add reservation because it overlaps with another in your cart."
    else
      @reservation = Reservation.create!(start_date: search.start_date, end_date: search.end_date, start_time_slot: search.start_time_slot,
                         end_time_slot: search.end_time_slot, spot_id: params[:spot_id], user_id: search.user_id, cart_id: @cart.id,
                         owner_id: Lease.find_by_spot_id(params[:spot_id]).user_id, 
                         confirmation_number: ["1","2","3","4","5","6","7","8","9","0"].shuffle.join.first(6))
      
      rh_id_group.each do |rh_id|
        ReservationRentHourRelationship.create!(reservation_id: @reservation.id, rent_hour_id: rh_id)
      end
      if current_user
        redirect_to search_url(Search.where(user_id: current_user.id).last)
      else
        redirect_to new_search_url
      end
    end
  end
  
  def checkout
    @cart = Cart.find_by_id(session[:cart_id])
  end
  
  def index
    @reservations = Reservation.where(user_id: current_user.id).where(paid: true).where("end_date >= ?", Date.today)
  end
  
  def purchase
    if Cart.find_by_id(session[:cart_id])
      @cart = Cart.find_by_id(session[:cart_id])
      
      unless @cart.rent_hours.where(reserved: true).count != 0
        if params[:email].present? || current_user
          @cart.reservations.each do |res|
            res.paid = true
            res.save
          end
          @cart.rent_hours.each do |rh|
            rh.reserved = true
            rh.save
          end
          @user = current_user if current_user
          @cart.reservations.each do |reservation|
            if current_user
              UserMailer.reservation_email(@user, reservation).deliver
            else
              reservation.update_attribute(:email, params[:email])
              reservation.update_attribute(:license_plate, params[:license_plate])
              UserMailer.reservation_email_no_user(reservation).deliver
            end
          end
          @cart.destroy
          session.delete(:cart_id)
          redirect_to root_url, notice: "Your payment has been processed. Parking passes have been
          sent to your email."
        else
          redirect_to checkout_path, alert: "Please enter an email address for parking pass delivery."
        end
      else
        redirect_to root_url, alert: "Your requested parking spot has already been reserved. Please search for a new spot and time."
        @cart.destroy
        session.delete(:cart_id)
      end
    else
      redirect_to checkout_path, alert: "There was a problem finding your reservation."
    end
  end
  
  def email
    @user = current_user
    @reservation = Reservation.find_by_id(params[:reservation_id])
    UserMailer.reservation_email(@user, @reservation).deliver
    redirect_to reservations_path, notice: "Parking pass has been resent to your email."
  end
  
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    
    redirect_to new_search_url
  end
  
end
