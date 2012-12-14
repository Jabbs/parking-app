class AddIndexesToSearches < ActiveRecord::Migration
  def change
    add_index :searches, :building_id
    add_index :searches, :user_id
  end
end
