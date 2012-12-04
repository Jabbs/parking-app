class AddWebsiteToBuilding < ActiveRecord::Migration
  def change
    add_column :buildings, :website, :string
  end
end
