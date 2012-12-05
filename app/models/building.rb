class Building < ActiveRecord::Base
  attr_accessible :name, :code, :address, :city, :state, :zip_code, :image, :garage_instructions, :website,
                  :contact_name, :contact_email, :contact_phone
  validates :name, :address, :city, :state, :zip_code, presence: true
  has_many :users
  has_many :spots
end
