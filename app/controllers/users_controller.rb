class UsersController < ApplicationController
  before_filter :signed_in_user, except: [:new, :create]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:index, :destroy]
  before_filter :signed_in_user_go_to_root, only: [:new, :create]
  
  def show
    @user = User.find(params[:id])
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 30)
  end

  def new
    @user = User.new
    @buildings = Building.where(approved: true).order("name ASC")
  end
  
  def create
    @user = User.new(params[:user])
    @buildings = Building.all
    @building = Building.find_by_id(params[:user][:building_id])

    if @building && params[:building_code] != @building.code
      redirect_to new_user_url, alert: "Building code is incorrect." 
    elsif @user.save
      sign_in @user
      @user.send_verification_email
      redirect_to new_listing_url, notice: "Welcome #{@user.first_name} #{@user.last_name}! A verification email has been sent to 
                                     your email."
    else
      render action: "new"
    end
  end
  
  private
  
    def signed_in_user_go_to_root
      if signed_in?
        redirect_to root_url, notice: "Please sign out to create a new user."
      end
    end
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
