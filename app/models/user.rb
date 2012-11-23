class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password_digest, :building_id, :password, :password_confirmation
  validates :first_name, :last_name, :building_id, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  belongs_to :building
  has_many :leases
  has_many :listings
  has_many :rent_hours, through: :listings
  has_many :spots, through: :leases
  has_secure_password
  before_save { self.email.downcase! }
  before_save { self.first_name.capitalize! }
  before_save { self.last_name.capitalize! }
  before_create { generate_token(:auth_token) }
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
