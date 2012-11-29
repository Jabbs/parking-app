class CartRentHourRelationship < ActiveRecord::Base
  attr_accessible :cart_id, :rent_hour_id
  belongs_to :cart
  belongs_to :rent_hour
end
