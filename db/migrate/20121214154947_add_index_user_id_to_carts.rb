class AddIndexUserIdToCarts < ActiveRecord::Migration
  def change
    add_index :carts, :user_id
  end
end
