class ChangeColumnsInSearches < ActiveRecord::Migration
  def change
    add_column :searches, :start_time_slot, :integer
    add_column :searches, :end_time_slot, :integer
  end
end
