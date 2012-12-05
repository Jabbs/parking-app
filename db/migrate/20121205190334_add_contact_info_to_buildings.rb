class AddContactInfoToBuildings < ActiveRecord::Migration
  def change
    add_column :buildings, :contact_name, :string
    add_column :buildings, :contact_email, :string
    add_column :buildings, :contact_phone, :string
  end
end
