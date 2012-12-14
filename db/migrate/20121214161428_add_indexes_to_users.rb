class AddIndexesToUsers < ActiveRecord::Migration
  def change
    add_index :users, :building_id
    add_index :users, :email, unique: true
  end
end
