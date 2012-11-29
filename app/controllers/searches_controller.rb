class SearchesController < ApplicationController
  def new
    @listings = Listing.order("start_date ASC").order("start_time_slot ASC").paginate(page: params[:page], per_page: 10)
    @search = Search.new
    @cart = Cart.where(user_id: current_user.id).last if Cart.where(user_id: current_user.id).last
    
  end

  def create
    @listings = Listing.order("start_date ASC").order("start_time_slot ASC").paginate(page: params[:page], per_page: 10)
    @search = Search.new
    @search2 = Search.find(params[:id]) if params[:id]
    @cart = Cart.where(user_id: current_user.id).last if Cart.where(user_id: current_user.id).last
    
    @search = Search.new(params[:search])
    @search.user_id = current_user.id
    
    if @search.save
      redirect_to @search
    elsif params[:id]
      render 'show'
    else
      render 'new'
    end
  end

  def show
    @listings = Listing.order("start_date ASC").order("start_time_slot ASC").paginate(page: params[:page], per_page: 10)
    @search = Search.new
    @search2 = Search.find(params[:id])
    @cart = Cart.where(user_id: current_user.id).last if Cart.where(user_id: current_user.id).last
    
  end
end
