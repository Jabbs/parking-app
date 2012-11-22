class RentHour < ActiveRecord::Base
  attr_accessible :date, :listing_id, :renter_id, :reserved, :time_slot
  validates :date, :listing_id, :time_slot, presence: true
  # validates :time_slot, :uniqueness => { :scope => :date(where(listing_id: listing_id)),
  #           :message => "Overlaps with another one of your listings." }
  belongs_to :listing
  belongs_to :renter, class_name: "User"
  # validate :time_slot_cannot_match_others
  # 
  # def time_slot_cannot_match_others
  #   if RentHour.where(time_slot: time_slot).where(date: date).where(listing_id: listing_id).count != 0
  #     errors.add(:time_slot, "is already taken.")
  #   end
  # end
  
  def expiration_date_cannot_be_in_the_past
    if !expiration_date.blank? and expiration_date < Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end
 
  def discount_cannot_be_greater_than_total_value
    if discount > total_value
      errors.add(:discount, "can't be greater than total value")
    end
  end
  
end
