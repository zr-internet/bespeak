class AddNameAndPhoneToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :name, :string
    add_column :customers, :phone, :string, :length => 10
  end
end
