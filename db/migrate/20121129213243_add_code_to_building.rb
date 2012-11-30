class AddCodeToBuilding < ActiveRecord::Migration
  def change
    add_column :buildings, :code, :string
  end
end
