class Spot < ActiveRecord::Base
  attr_accessible :building_id, :name, :registered
  validates :name, presence: true
  belongs_to :building
end
