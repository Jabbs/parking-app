class CreateReservationRentHourRelationships < ActiveRecord::Migration
  def change
    create_table :reservation_rent_hour_relationships do |t|
      t.integer :reservation_id
      t.integer :rent_hour_id

      t.timestamps
    end
  end
end
