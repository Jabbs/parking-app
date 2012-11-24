class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.date :begin_date
      t.date :end_date
      t.integer :building_id
      t.integer :begin_time
      t.integer :end_time

      t.timestamps
    end
  end
end
