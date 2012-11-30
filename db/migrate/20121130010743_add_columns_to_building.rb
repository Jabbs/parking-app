class AddColumnsToBuilding < ActiveRecord::Migration
  def change
    add_column :buildings, :address, :string
    add_column :buildings, :city, :string
    add_column :buildings, :state, :string
    add_column :buildings, :zip_code, :string
  end
end
