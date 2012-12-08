class Building < ActiveRecord::Base
  attr_accessible :name, :code, :address, :city, :state, :zip_code, :image, :garage_instructions, :website,
                  :contact_name, :contact_email, :contact_phone, :latitude, :longitude
  validates :name, :address, :city, :state, :zip_code, presence: true
  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?
  has_many :users
  has_many :spots
  
  def full_address
    [address, city, state, zip_code].compact.join(', ')
  end
  
  def full_building_name
    "#{name} - " + [address, city, state].compact.join(', ')
  end
end
