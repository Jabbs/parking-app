class AddIndexToSpots < ActiveRecord::Migration
  def change
    add_index :spots, :building_id
  end
end
