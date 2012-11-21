class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def show
  end

  def new
    @listing = Listing.new
    @spots = current_user.spots
  end
  
  def create
    @listing = Listing.new(params[:listing])
    @listing.user_id = current_user.id
    @spots = current_user.spots

    if @listing.save

      redirect_to root_url, notice: "Listing created"
    else
      render action: "new"
    end
  end

  def edit
  end
end
