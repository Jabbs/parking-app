class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @buildings = Building.all
  end
  
  def create
    @user = User.new(params[:user])
    @buildings = Building.all
    @building = Building.find_by_id(params[:user][:building_id])

    if @building && params[:building_code] != @building.code
      redirect_to new_user_url, alert: "Building code is incorrect." 
    elsif @user.save
      sign_in @user
      # @user.send_verification_email
      # UserMailer.welcome_email(@user).deliver
      redirect_to new_search_url, notice: "Welcome #{@user.first_name} #{@user.last_name}! A verification email has been sent to 
                                     your email."
    else
      render action: "new"
    end
  end
end
