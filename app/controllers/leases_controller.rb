class LeasesController < ApplicationController
  before_filter :signed_in_user
  
  def new
    @lease = Lease.new
    @spots = current_user.building.spots
  end
  
  def create
    @lease = Lease.new(params[:lease])
    @spots = current_user.building.spots
    @lease.user_id = current_user.id

    if @lease.save
      redirect_to new_listing_url, notice: "Your parking spot has been registered."
    else
      render action: "new"
    end
  end
end
