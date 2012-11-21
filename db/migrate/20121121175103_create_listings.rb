class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :user_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :spot_id
      t.integer :building_id

      t.timestamps
    end
  end
end
