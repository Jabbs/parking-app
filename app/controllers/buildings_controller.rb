class BuildingsController < ApplicationController
  before_filter :signed_in_user, except: [:new, :create, :show]
  before_filter :admin_user, except: [:new, :create, :show]
  
  def index
  end

  def show
    @building = Building.find(params[:id])
  end

  def new
    @building = Building.new
  end
  
  def create
    @building = Building.new(params[:building])
    
    if @building.save
      # notify admin by email
      UserMailer.new_building_admin_email(@building).deliver
      redirect_to root_url, notice: "Your form has been submitted. Thank you."
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
