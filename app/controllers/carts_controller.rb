class CartsController < ApplicationController
  
  def create
    if Cart.where(user_id: current_user).last
      @cart = Cart.where(user_id: current_user).last
    else
      @cart = Cart.create!(user_id: current_user.id)
    end
    rh_id_group = params[:query]
    rh_id_group.each do |rh_id|
      CartRentHourRelationship.create!(cart_id: @cart.id, rent_hour_id: rh_id)
    end
    redirect_to search_url(Search.where(user_id: current_user.id).last)
  end
end
