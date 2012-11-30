namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_building
    make_spots
  end
end

def make_building
  10.times do
    type = ["Condominiums", "Apartments", "Apartment Complex", "Building", "Complex"]
    name  = Faker::Company.name + " #{type.shuffle.first}"
    address = Faker::Address.street_address
    city = Faker::Address.city
    state = Faker::Address.state
    zip_code = Faker::Address.zip_code
    code = "123456"
    Building.create!(name:       name,
                     address:    address,
                     city:       city,
                     state:      state,
                     zip_code:   zip_code,
                     code:    code)
  end
end

def make_spots
  Building.all.each do |building|
    50.times do |n|
      Spot.create!(name:       n+1,
                   building_id: building.id)
    end
  end
end