class AddEmailToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :email, :string
    add_column :reservations, :license_plate, :string
  end
end
