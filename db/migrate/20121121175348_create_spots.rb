class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.string :name
      t.integer :building_id

      t.timestamps
    end
  end
end
