class AddIndexToRentHours < ActiveRecord::Migration
  def change
    add_index :rent_hours, :id
  end
end
