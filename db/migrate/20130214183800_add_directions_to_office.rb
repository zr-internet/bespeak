class AddDirectionsToOffice < ActiveRecord::Migration
  def change
    add_column :offices, :directions, :text
  end
end
