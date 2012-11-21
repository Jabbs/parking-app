class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_token, :string
    add_column :users, :verified, :boolean, default: false
    add_column :users, :verification_token, :string
    add_column :users, :verification_sent_at, :datetime
    add_column :users, :verified_at, :datetime
    add_column :users, :password_reset_token, :string
    add_column :users, :password_reset_sent_at, :datetime
    add_column :users, :admin, :boolean, default: false
  end
end
