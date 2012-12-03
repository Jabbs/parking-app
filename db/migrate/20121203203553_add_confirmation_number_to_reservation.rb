class AddConfirmationNumberToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :confirmation_number, :string
  end
end
