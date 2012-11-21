class CreateLeases < ActiveRecord::Migration
  def change
    create_table :leases do |t|
      t.integer :user_id
      t.integer :spot_id
      t.boolean :confirmed, default: false

      t.timestamps
    end
  end
end
