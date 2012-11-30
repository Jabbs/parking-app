class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.date :end_date
      t.integer :start_time_slot
      t.integer :end_time_slot
      t.integer :spot_id
      t.integer :user_id

      t.timestamps
    end
  end
end
