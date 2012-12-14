class AddIndexesToLeases < ActiveRecord::Migration
  def change
    add_index :leases, :user_id
    add_index :leases, :spot_id
  end
end
