class UsersController < ApplicationController
  def show
  end

  def new
    @user = User.new
    @buildings = Building.all
  end
  
  def create
    @user = User.new(params[:user])
    @buildings = Building.all

    if @user.save
      sign_in @user
      # @user.send_verification_email
      # UserMailer.welcome_email(@user).deliver
      redirect_to root_url, notice: "Welcome #{@user.first_name} #{@user.last_name}! A verification email has been sent to 
                                     your email."
    else
      render action: "new"
    end
  end
end
