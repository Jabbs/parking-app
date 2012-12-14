class DropTableCartRentHourRelationships < ActiveRecord::Migration
  def change
    drop_table :cart_rent_hour_relationships
  end
end
