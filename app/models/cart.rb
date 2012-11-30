class Cart < ActiveRecord::Base
  attr_accessible :user_id
  has_many :reservations
  has_many :rent_hours, through: :reservations
end
