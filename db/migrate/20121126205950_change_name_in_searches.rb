class ChangeNameInSearches < ActiveRecord::Migration
  def up
    add_column :searches, :start_date, :date
  end

  def down
    remove_column :searches, :begin_date
  end
end
