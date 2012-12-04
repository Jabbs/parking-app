class VerificationsController < ApplicationController
  def show
    if User.find_by_verification_token(params[:id])
      @user = User.find_by_verification_token(params[:id])
      @user.update_attribute(:verified, true)
      @user.update_attribute(:verified_at, Time.zone.now)
      redirect_to root_url, notice: "Your account has been verified."
    else
      redirect_to root_url, notice: "There was a problem verifying your account. Please contact support@waytosettle.com 
                                     for more details."
    end
  end
end
