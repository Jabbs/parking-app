class RemoveRentHourIdFromCarts < ActiveRecord::Migration
  def change
    remove_column :carts, :rent_hour_id
  end
end
