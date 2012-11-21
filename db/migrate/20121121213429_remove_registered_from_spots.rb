class RemoveRegisteredFromSpots < ActiveRecord::Migration
  def up
    remove_column :spots, :registered
  end

  def down
    add_column :spots, :registered, :boolean
  end
end
