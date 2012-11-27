class RentHour < ActiveRecord::Base
  attr_accessible :date, :listing_id, :renter_id, :reserved, :time_slot
  validates :date, :listing_id, :time_slot, presence: true
  # validates :time_slot, :uniqueness => { :scope => :date,
  #          :message => "Overlaps with another one of your listings." }
  belongs_to :listing
  belongs_to :renter, class_name: "User"
  belongs_to :spot
  
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
  
  def time_slot_hour
    x = self.time_slot
    TIMES.each do |key, value|
      if value == x
        return key
      end
    end
  end
  
end
