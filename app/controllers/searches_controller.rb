class SearchesController < ApplicationController
  def new
    @buildings = Building.where(approved: true).order("name ASC")
    @listings = Listing.order("start_date ASC").order("start_time_slot ASC").paginate(page: params[:page], per_page: 10)
    @search = Search.new
    @cart = Cart.find_by_id(session[:cart_id]) if session[:cart_id]
  end

  def create
    @buildings = Building.where(approved: true).order("name ASC")
    @listings = Listing.order("start_date ASC").order("start_time_slot ASC").paginate(page: params[:page], per_page: 10)
    @search = Search.new
    @search2 = Search.find(params[:id]) if params[:id]
    @cart = Cart.find_by_id(session[:cart_id]) if session[:cart_id]
    
    @search = Search.new(params[:search])
    if current_user
      @search.user_id = current_user.id
    end
    
    if @search.save
      redirect_to @search
    elsif params[:id]
      render 'show'
    else
      render 'new'
    end
  end

  def show
    @buildings = Building.where(approved: true).order("name ASC")
    @listings = Listing.order("start_date ASC").order("start_time_slot ASC").paginate(page: params[:page], per_page: 10)
    @search = Search.new
    @search2 = Search.find(params[:id])
    @cart = Cart.find_by_id(session[:cart_id]) if session[:cart_id]
  end
end
