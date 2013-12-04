class CustomersPerSite < ActiveRecord::Migration
  def change
  	change_table :customers do |t|
  		t.remove_index	:email
  	end

  	add_index :customers, [:site_id, :email], unique: true
  end
end
