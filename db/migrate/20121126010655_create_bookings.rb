class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :course
      t.references :customer
      t.integer :attendees

      t.timestamps
    end
  end
end
