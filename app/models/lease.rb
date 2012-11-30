class Lease < ActiveRecord::Base
  attr_accessible :confirmed, :spot_id
  validates :spot_id, :user_id, presence: true
  validates :confirmed, :acceptance => { accept: true, message: "parking spot has not been checked." }
  validates :spot_id, :uniqueness => { scope: :user_id, message: "has already been registered." }
  belongs_to :user
  belongs_to :spot
end
