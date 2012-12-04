class BuildingsController < ApplicationController
  def index
  end

  def show
    @building = Building.find(params[:id])
  end

  def new
  end

  def edit
  end
end
