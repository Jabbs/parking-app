class SearchesController < ApplicationController
  def new
    @listings = Listing.order("start_date ASC").order("start_time_slot ASC").paginate(page: params[:page], per_page: 10)
    @search = Search.new
    
  end

  def create
    @listings = Listing.order("start_date ASC").order("start_time_slot ASC").paginate(page: params[:page], per_page: 10)
    
    @search = Search.new(params[:search])
    @search.user_id = current_user.id
    
    if @search.save
      redirect_to @search
    else
      render 'new'
    end
  end

  def show
    @listings = Listing.order("start_date ASC").order("start_time_slot ASC").paginate(page: params[:page], per_page: 10)
    @search = Search.new
    @search2 = Search.find(params[:id])
  end
end
