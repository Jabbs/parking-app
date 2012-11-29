class ListingsController < ApplicationController
  def index
    @listings = Listing.where("start_date >= ?", Date.today)
    @renthours_today = RentHour.where(date: Date.today)
    @renthours_today_1 = RentHour.where(date: (Date.today + 1))
    @renthours_today_2 = RentHour.where(date: (Date.today + 2))
    @renthours_today_3 = RentHour.where(date: (Date.today + 3))
    @renthours_today_4 = RentHour.where(date: (Date.today + 4))
    @renthours_today_5 = RentHour.where(date: (Date.today + 5))
    @renthours_today_6 = RentHour.where(date: (Date.today + 6))
  end

  def show
  end

  def new
    @listing = Listing.new
    @listings = Listing.where(user_id: current_user.id).order("start_date ASC").order("spot_id ASC")
    @spots = current_user.spots
  end
  
  def create
    @listings = Listing.where(user_id: current_user.id)
    @listing = Listing.new(params[:listing])
    @listing.user_id = current_user.id
    @listing.building_id = current_user.building_id
    @spots = current_user.spots
    
    if @listing.save
      
      if current_user.rent_hours.where(spot_id: @listing.spot_id).where(:date => (@listing.start_date..@listing.end_date)).where(:time_slot => (@listing.start_time_slot..23)).count != 0
        @listing.delete
        redirect_to new_listing_url, alert: "This listing overlaps with a previous listing you have created. Please select a new date and time."
        return
      end if @listing.start_date != @listing.end_date
      
      if current_user.rent_hours.where(spot_id: @listing.spot_id).where(:date => (@listing.start_date..@listing.end_date)).where(:time_slot => (0..(@listing.end_time_slot - 1))).count != 0
        @listing.delete
        redirect_to new_listing_url, alert: "This listing overlaps with a previous listing you have created. Please select a new date and time."
        return
      end if @listing.start_date != @listing.end_date
      
      if current_user.rent_hours.where(spot_id: @listing.spot_id).where(:time_slot => (@listing.start_time_slot..@listing.end_time_slot)).count != 0
        @listing.delete
        redirect_to new_listing_url, alert: "This listing overlaps with a previous listing you have created. Please select a new date and time."
        return
      end if @listing.start_date == @listing.end_date
      
      # ---------------create rent hours ---------------
      
      x = (@listing.end_date - @listing.start_date).to_i - 1
      x.times do |n|
        date = @listing.start_date + (n + 1).days
        24.times do |time_slot|
          rh = RentHour.new
          rh.listing_id = @listing.id
          rh.date = date
          rh.time_slot = time_slot
          rh.spot_id = @listing.spot_id
          rh.save!
        end
      end unless x == -1 || x == 0
      y = 24 - @listing.start_time_slot
      n = 24
      y.times {
        rh = RentHour.new
        rh.listing_id = @listing.id
        rh.date = @listing.start_date
        rh.spot_id = @listing.spot_id
        rh.time_slot = n - 1
        n = n - 1
        rh.save!
      } unless x == -1
      z = @listing.end_time_slot
      n = 24
      z.times do |n|
        rh = RentHour.new
        rh.listing_id = @listing.id
        rh.spot_id = @listing.spot_id
        rh.date = @listing.end_date
        rh.time_slot = n
        rh.save!
      end unless x == -1 || z == 0
      if x == -1
        w = @listing.end_time_slot - @listing.start_time_slot
        v = @listing.start_time_slot
        w.times {
          rh = RentHour.new
          rh.listing_id = @listing.id
          rh.spot_id = @listing.spot_id
          rh.date = @listing.end_date
          rh.time_slot = v
          v = v + 1
          rh.save!
        }
      end
      
      # ----------------end creating rent hours ---------
      
      redirect_to new_listing_url, notice: "Listing created"
    else
      render action: "new"
    end
  end

  def edit
  end
  
  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    
    redirect_to new_listing_url
  end
end
