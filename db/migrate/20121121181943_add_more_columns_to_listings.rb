class AddMoreColumnsToListings < ActiveRecord::Migration
  def change
    add_column :listings, :start_date, :date
    add_column :listings, :end_date, :date
    add_column :listings, :start_time_slot, :integer
    add_column :listings, :end_time_slot, :integer
  end
end
