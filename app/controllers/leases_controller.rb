class LeasesController < ApplicationController
  def new
    @lease = Lease.new
    @spots = current_user.building.spots
  end
  
  def create
    @lease = Lease.new(params[:lease])
    @spots = current_user.building.spots
    @lease.user_id = current_user.id

    if @lease.save
      redirect_to root_url, notice: "Your spot has been registered."
    else
      render action: "new"
    end
  end
end
