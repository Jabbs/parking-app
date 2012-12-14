class AddIndexesToListings < ActiveRecord::Migration
  def change
    add_index :listings, :user_id
    add_index :listings, :spot_id
    add_index :listings, :building_id
    add_index :listings, :end_date
    add_index :listings, :start_date
    add_index :listings, :start_time_slot
    add_index :listings, :end_time_slot
  end
end
