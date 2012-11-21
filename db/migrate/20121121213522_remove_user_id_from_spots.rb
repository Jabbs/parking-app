class RemoveUserIdFromSpots < ActiveRecord::Migration
  def up
    remove_column :spots, :user_id
  end

  def down
    add_column :spots, :user_id, :integer
  end
end
