class AddBuildingIdToRentHours < ActiveRecord::Migration
  def change
    add_column :rent_hours, :building_id, :integer
  end
end
