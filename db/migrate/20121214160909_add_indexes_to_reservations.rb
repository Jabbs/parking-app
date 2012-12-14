class AddIndexesToReservations < ActiveRecord::Migration
  def change
    add_index :reservations, :spot_id
    add_index :reservations, :user_id
    add_index :reservations, :cart_id
    add_index :reservations, :owner_id
  end
end
