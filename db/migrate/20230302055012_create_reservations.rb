class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :code, index: { unique: true }

      t.references :guest 

      t.string :status
      t.string :start_date
      t.string :end_date

      t.string :currency
      t.float :payout_amount
      t.float :security_amount
      t.float :total_amount

      t.integer :nights

      t.integer :total_number_of_guests
      t.integer :number_of_adults
      t.integer :number_of_children
      t.integer :number_of_infants
      
      t.timestamps
    end
  end
end
