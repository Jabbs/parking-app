class SpotsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user
  
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
  
  private
  
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
  
end
