class AddSpotIdToRentHour < ActiveRecord::Migration
  def change
    add_column :rent_hours, :spot_id, :integer
  end
end
