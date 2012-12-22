class AddTimeZoneToOffice < ActiveRecord::Migration
  def up
    add_column :offices, :time_zone, :string
  end

	def down
		remove_column :offices, :time_zone
	end
end