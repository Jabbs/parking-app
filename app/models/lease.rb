class Lease < ActiveRecord::Base
  attr_accessible :confirmed, :spot_id
  validates :spot_id, :user_id, presence: true
  belongs_to :user
  belongs_to :spot
end
