class ReservationRentHourRelationship < ActiveRecord::Base
  attr_accessible :rent_hour_id, :reservation_id
  belongs_to :rent_hour
  belongs_to :reservation
end
