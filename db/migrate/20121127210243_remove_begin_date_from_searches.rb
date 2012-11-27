class RemoveBeginDateFromSearches < ActiveRecord::Migration
  def up
    remove_column :searches, :begin_date
  end

  def down
    add_column :searches, :begin_date, :date
  end
end
