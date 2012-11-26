class SearchesController < ApplicationController
  def new
    @listings = Listing.all
    @search = Search.new
    @search2 = Search.where(user_id: current_user.id).last if current_user.searches.any?
  end

  def create
    @search = Search.create!(params[:search])
    @search.user_id = current_user.id
    @search.save
    redirect_to @search
  end

  def show
    @listings = Listing.all
    @search = Search.new
    @search2 = Search.find(params[:id])
  end
end
