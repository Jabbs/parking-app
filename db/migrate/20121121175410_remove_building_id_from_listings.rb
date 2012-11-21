class RemoveBuildingIdFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :building_id
  end
end
