class AddCartIdToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :cart_id, :integer
  end
end
