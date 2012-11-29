class Cart < ActiveRecord::Base
  attr_accessible :user_id
  has_many :cart_rent_hour_relationships, dependent: :destroy
  has_many :rent_hours, through: :cart_rent_hour_relationships
end
