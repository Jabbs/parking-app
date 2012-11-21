namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_spots
  end
end

def make_spots
  50.times do |n|
    Spot.create!(name:       n+1,
                 user_id:    1,
                 building_id: 1)
  end
end