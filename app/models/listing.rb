class Listing < ActiveRecord::Base
  attr_accessible :end_date, :spot_id, :start_date, :start_time_slot, :end_time_slot
  validates :end_date, :spot_id, :start_date, :start_time_slot, :end_time_slot, presence: true
  belongs_to :spot
  belongs_to :building
  belongs_to :user
  has_many :rent_hours, dependent: :destroy
  validates_date :start_date, :on_or_after => lambda { Date.today }
  validates_date :start_date, :before => lambda { 1.year.from_now }
  validates_date :end_date, :on_or_after => :start_date
  validates :end_time_slot, :numericality => { greater_than: :start_time_plus_3_hours }, if: :same_day?
  
  def same_day?
    start_date == end_date
  end
  
  def start_time_plus_3_hours
    start_time_slot + 3
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
end
