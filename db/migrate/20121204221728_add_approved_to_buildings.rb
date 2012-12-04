class AddApprovedToBuildings < ActiveRecord::Migration
  def change
    add_column :buildings, :approved, :boolean, default: false
  end
end
