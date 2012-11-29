class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :amount_cents, :default => 0, :null => false
      t.string :method, :default => "cash", :null => false
      t.string :token
      t.references :booking

      t.timestamps
    end
    add_index :payments, :booking_id
  end
end
