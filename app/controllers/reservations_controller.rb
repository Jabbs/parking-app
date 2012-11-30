class ReservationsController < ApplicationController
  
  def show
    @reservation = Reservation.find(params[:id])
  end
  
  def create
    if Cart.where(user_id: current_user).last
      @cart = Cart.where(user_id: current_user).last
    else
      @cart = Cart.create!(user_id: current_user.id)
    end
    search = Search.find_by_id(params[:search_id])
    @reservation = Reservation.create!(start_date: search.start_date, end_date: search.end_date, start_time_slot: search.start_time_slot,
                       end_time_slot: search.end_time_slot, spot_id: params[:spot_id], user_id: search.user_id, cart_id: @cart.id)
    rh_id_group = params[:rh_group]
    rh_id_group.each do |rh_id|
      ReservationRentHourRelationship.create!(reservation_id: @reservation.id, rent_hour_id: rh_id)
    end
    redirect_to search_url(Search.where(user_id: current_user.id).last)
  end
  
  def checkout
    @cart = Cart.where(user_id: current_user.id).last if Cart.where(user_id: current_user.id).last
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
