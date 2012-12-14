class AddIndexesToReservationRentHourRelationships < ActiveRecord::Migration
  def change
    add_index :reservation_rent_hour_relationships, :reservation_id
    add_index :reservation_rent_hour_relationships, :rent_hour_id
    add_index :reservation_rent_hour_relationships, [:rent_hour_id, :reservation_id], unique: true, name: 'index_rent_hour_reservation'
  end
end
