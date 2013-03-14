class AddIndexesToSites < ActiveRecord::Migration
  def change
		add_index :sites, :token, unique: true
  end
end
