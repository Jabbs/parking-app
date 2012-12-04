class Building < ActiveRecord::Base
  attr_accessible :name, :code, :address, :city, :state, :zip_code, :image, :garage_instructions
  has_many :users
  has_many :spots
end
