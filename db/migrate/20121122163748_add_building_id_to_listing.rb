class AddBuildingIdToListing < ActiveRecord::Migration
  def change
    add_column :listings, :building_id, :integer
  end
end
