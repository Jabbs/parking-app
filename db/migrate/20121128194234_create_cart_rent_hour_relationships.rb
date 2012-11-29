class CreateCartRentHourRelationships < ActiveRecord::Migration
  def change
    create_table :cart_rent_hour_relationships do |t|
      t.integer :cart_id
      t.integer :rent_hour_id

      t.timestamps
    end
  end
end
