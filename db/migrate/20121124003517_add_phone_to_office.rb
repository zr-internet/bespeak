class AddPhoneToOffice < ActiveRecord::Migration
  def change
    add_column :offices, :phone, :string, :length => 10
  end
end
