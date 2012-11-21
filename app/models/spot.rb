class Spot < ActiveRecord::Base
  attr_accessible :building_id, :name, :user_id, :registered
  validates :name, presence: true
  belongs_to :building
end
