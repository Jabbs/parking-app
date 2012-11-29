class Search < ActiveRecord::Base
  attr_accessible :start_date, :building_id, :end_date, :start_time_slot, :end_time_slot
  validates :end_date, :start_date, :start_time_slot, :end_time_slot, :building_id, presence: true
  validates_date :start_date, :on_or_after => lambda { Date.today }
  validates_date :start_date, :before => lambda { 1.year.from_now }
  validates_date :end_date, :on_or_after => :start_date
  validates :end_time_slot, :numericality => { greater_than: :start_time_slot }, if: :same_day?
  
  def same_day?
    start_date == end_date
  end
  
  def rent_hour_groups
    @rent_hour_groups ||= find_rent_hours
  end
  
  TIMES = [  
    ["12:00am", 0],
    ["1:00am", 1], 
    ["2:00am", 2], 
    ["3:00am", 3], 
    ["4:00am", 4], 
    ["5:00am", 5], 
    ["6:00am", 6], 
    ["7:00am", 7], 
    ["8:00am", 8], 
    ["9:00am", 9], 
    ["10:00am", 10], 
    ["11:00am", 11], 
    ["12:00pm", 12], 
    ["1:00pm", 13], 
    ["2:00pm", 14], 
    ["3:00pm", 15], 
    ["4:00pm", 16], 
    ["5:00pm", 17], 
    ["6:00pm", 18], 
    ["7:00pm", 19], 
    ["8:00pm", 20], 
    ["9:00pm", 21], 
    ["10:00pm", 22], 
    ["11:00pm", 23], 
    ]
  
  def time_slot_start_hour
    x = self.start_time_slot
    TIMES.each do |key, value|
      if value == x
        return key
      end
    end
  end
  
  def time_slot_end_hour
    x = self.end_time_slot
    TIMES.each do |key, value|
      if value == x
        return key
      end
    end
  end

  private

  def find_rent_hours
    rent_hours = RentHour.where(:date => (start_date..end_date)).where(reserved: false).order("spot_id ASC").order("date ASC").order("time_slot ASC")
    
    unwanted_start_hours = RentHour.where(date: start_date).where(:time_slot => (0...start_time_slot)) unless start_date == end_date
    unwanted_end_hours = RentHour.where(date: end_date).where(:time_slot => (end_time_slot..23)) unless start_date == end_date
    rent_hours = (rent_hours - unwanted_start_hours - unwanted_end_hours) unless start_date == end_date
    
    rent_hours = rent_hours.where(:time_slot => (start_time_slot..end_time_slot)).where(reserved: false) if start_date == end_date
    rent_hours = rent_hours - rent_hours.where(time_slot: end_time_slot).where(reserved: false) if start_date == end_date
    
    total_hours = (((end_date - start_date).to_i - 1) * 24) + ((start_time_slot..23).count) + ((0...end_time_slot).count)
    total_hours = (start_time_slot...end_time_slot).count if start_date == end_date
    
    spot_ids = rent_hours.uniq { |s| s.spot.name }.map { |rh| rh.spot.id }
    spot_ids.each do |spot_id|
      rent_hours_with_same_spot_id_count = rent_hours.select { |rh| rh.spot_id == spot_id }.count
      rent_hours.delete_if { |x| x.spot_id == spot_id } if total_hours != rent_hours_with_same_spot_id_count
    end
    
    rent_hour_groups = []
    
    rent_hours.uniq { |s| s.spot.id }.each do |rh|
      x = rent_hours.select { |y| y.spot_id == rh.spot_id }
      rent_hour_groups << x
    end
    
    rent_hour_groups2 = []
    
    if Cart.where(user_id: user_id).last
      rent_hour_groups.each do |rh_group|
        rent_hour_groups2 << rh_group unless Cart.where(user_id: user_id).last.rent_hours.find_by_id(rh_group.first)
      end
    else
      rent_hour_groups2 = rent_hour_groups
    end
    
    rent_hour_groups2
    
    
    # listings = listings.where(:start_date => ( begin_date...end_date) ) if begin_date.present?
    # listings = listings.where("start_date <= ?", start_date)
    # listings = listings.where("end_date >= ?", start_date)
    # products = products.where("name like ?", "%#{keywords}%") if keywords.present?
    # products = products.where(category_id: category_id) if category_id.present?
    # products = products.where("price >= ?", min_price) if min_price.present?
    # products = products.where("price <= ?", max_price) if max_price.present?
  end
end
