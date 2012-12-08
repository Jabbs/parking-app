class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password_digest, :building_id, :password, :password_confirmation
  validates :first_name, :last_name, :building_id, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  belongs_to :building
  has_many :leases
  has_many :listings
  has_many :searches
  has_many :rent_hours, through: :listings
  has_many :spots, through: :leases
  has_many :reservations
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
  
  def send_verification_email
    generate_token(:verification_token)
    self.verification_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.verification_email(self).deliver
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end
end
