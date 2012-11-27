class RemoveColumnsFromSearches < ActiveRecord::Migration
  def change
    remove_column :searches, :end_time
    remove_column :searches, :begin_time
  end
end
