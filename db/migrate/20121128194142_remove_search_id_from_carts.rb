class RemoveSearchIdFromCarts < ActiveRecord::Migration
  def up
    remove_column :carts, :search_id
  end

  def down
    add_column :carts, :search_id, :integer
  end
end
