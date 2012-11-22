class CreateRentHours < ActiveRecord::Migration
  def change
    create_table :rent_hours do |t|
      t.integer :listing_id
      t.boolean :reserved, default: false
      t.integer :renter_id
      t.date :date
      t.integer :time_slot

      t.timestamps
    end
  end
end
