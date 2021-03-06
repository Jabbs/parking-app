class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      redirect_to root_url, notice: "Email sent with password reset instructions."
    else
      redirect_to new_password_reset_path, alert: "Email not found"
    end
  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      sign_in @user
      redirect_to new_listing_url, notice: "Password has been reset!"
    else
      redirect_to edit_password_reset_path, alert: "Invalid password/confirmation combination."
    end
  end
end
