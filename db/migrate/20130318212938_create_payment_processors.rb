class CreatePaymentProcessors < ActiveRecord::Migration
  def change
    create_table :payment_processors do |t|
      t.string :name
      t.string :login
      t.string :key
			t.references :site

      t.timestamps
    end

		add_index :payment_processors, :site_id
  end
end
