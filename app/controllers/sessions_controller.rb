class SessionsController < ApplicationController
  before_filter :signed_in_user_go_to_root, only: [:new, :create]
  
  def new
    @buildings = Building.where(approved: true).order("name ASC")
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_to new_listing_url
    else
      redirect_to new_listing_url, alert: "Invalid email/password combination"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    Cart.find_by_id(session[:cart_id]).destroy if Cart.find_by_id(session[:cart_id])
    session.delete(:cart_id) if session[:cart_id]
    redirect_to root_url
  end
  
  private
  
    def signed_in_user_go_to_root
      if signed_in?
        redirect_to root_url
      end
    end
end
