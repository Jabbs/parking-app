class AddIndexesToRentHours < ActiveRecord::Migration
  def change
    add_index :rent_hours, :listing_id
    add_index :rent_hours, :renter_id
    add_index :rent_hours, :date
    add_index :rent_hours, :time_slot
    add_index :rent_hours, :spot_id
    add_index :rent_hours, :building_id
  end
end
