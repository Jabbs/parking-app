class AddRegisteredToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :registered, :boolean, default: false
  end
end
