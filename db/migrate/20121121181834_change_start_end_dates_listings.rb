class ChangeStartEndDatesListings < ActiveRecord::Migration
  def change
    remove_column :listings, :start_time
    remove_column :listings, :end_time
  end
end
