class SpotsController < ApplicationController
  def index
  end

  def new
    @spot = Spot.new
    @buildings = Building.all
  end
  
  def create
    @spot = Spot.new(params[:spot])
    @buildings = Building.all

    if @spot.save
      redirect_to root_url, notice: "Your spot has been registered."
    else
      render action: "new"
    end
  end

  def edit
  end
end
