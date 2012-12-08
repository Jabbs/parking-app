class ReservationsController < ApplicationController
  
  def show
    @reservation = Reservation.find(params[:id])
  end
  
  def create
    if session[:cart_id]
      @cart = Cart.find_by_id(session[:cart_id])
    else
      @cart = Cart.create!
      session[:cart_id] = @cart.id
    end
    search = Search.find_by_id(params[:search_id])
    @reservation = Reservation.create!(start_date: search.start_date, end_date: search.end_date, start_time_slot: search.start_time_slot,
                       end_time_slot: search.end_time_slot, spot_id: params[:spot_id], user_id: search.user_id, cart_id: @cart.id,
                       owner_id: Lease.find_by_spot_id(params[:spot_id]).user_id, 
                       confirmation_number: ["1","2","3","4","5","6","7","8","9","0"].shuffle.join.first(6))
    rh_id_group = params[:rh_group]
    rh_id_group.each do |rh_id|
      ReservationRentHourRelationship.create!(reservation_id: @reservation.id, rent_hour_id: rh_id)
    end
    if current_user
      redirect_to search_url(Search.where(user_id: current_user.id).last)
    else
      redirect_to new_search_url
    end
  end
  
  def checkout
    @cart = Cart.find_by_id(session[:cart_id])
  end
  
  def index
    @reservations = Reservation.where(user_id: current_user.id).where(paid: true).where("end_date >= ?", Date.today)
  end
  
  def purchase
    @cart = Cart.find_by_id(params[:cart_id])
    
    @cart.reservations.each do |res|
      res.paid = true
      res.save
    end
    @cart.rent_hours.each do |rh|
      rh.reserved = true
      rh.save
    end
    @user = current_user
    @cart.reservations.each do |reservation|
      UserMailer.reservation_email(@user, reservation).deliver
    end
    @cart.destroy
    redirect_to reservations_url, notice: "Your payment has been processed. Confirmation and parking reservation(s) have
    sent to your email."
  end
  
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    
    redirect_to new_search_url
  end
  
end
