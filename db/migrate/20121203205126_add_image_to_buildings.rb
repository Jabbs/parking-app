class AddImageToBuildings < ActiveRecord::Migration
  def change
    add_column :buildings, :image, :string
    add_column :buildings, :garage_instructions, :text
  end
end
