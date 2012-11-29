class ChangeCartIdName < ActiveRecord::Migration
  def up
    add_column :carts, :search_id, :integer
  end

  def down
    remove_column :carts, :rent_hour_id
  end
end
