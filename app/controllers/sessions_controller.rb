class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_to new_search_url
    else
      redirect_to login_url, alert: "Invalid email/password combination"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, notice: "You have successfully logged out."
  end
end
