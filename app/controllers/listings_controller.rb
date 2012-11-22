class ListingsController < ApplicationController
  def index
    @listings = Listing.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @listing = Listing.new
    @listings = Listing.where(user_id: current_user.id)
    @spots = current_user.spots
  end
  
  def create
    @listings = Listing.where(user_id: current_user.id)
    @listing = Listing.new(params[:listing])
    @listing.user_id = current_user.id
    @spots = current_user.spots

    if @listing.save
      
      # ---------------create rent hours ---------------
      
      x = (@listing.end_date - @listing.start_date).to_i - 1
      x = 0 if (@listing.end_date - @listing.start_date).to_i == 0
      x.times do |n|
        date = @listing.start_date + (n + 1).days
        24.times do |time_slot|
          rh = RentHour.new
          rh.listing_id = @listing.id
          rh.date = date
          rh.time_slot = (time_slot + 1)
          rh.save!
        end
      end unless x == 0
      if @listing.start_time_slot == 24
        y = 24
      else
        y = 24 - @listing.start_time_slot
      end
      n = 24
      y.times {
        rh = RentHour.new
        rh.listing_id = @listing.id
        rh.date = @listing.start_date
        rh.time_slot = n - 1
        n = n - 1
        rh.save!
      } unless x == 0
      z = @listing.end_time_slot - 1
      n = 24
      z.times do |n|
        rh = RentHour.new
        rh.listing_id = @listing.id
        rh.date = @listing.end_date
        rh.time_slot = n + 1
        rh.save!
      end unless x == 0
      if x == 0
        w = @listing.end_time_slot - @listing.start_time_slot
        v = @listing.start_time_slot
        w.times {
          rh = RentHour.new
          rh.listing_id = @listing.id
          rh.date = @listing.end_date
          rh.time_slot = v
          v = v + 1
          rh.save!
        }
      end
      
      # ----------------end creating rent hours ---------
      
      redirect_to root_url, notice: "Listing created"
    else
      render action: "new"
    end
  end

  def edit
  end
  
  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    
    redirect_to root_url
  end
end
