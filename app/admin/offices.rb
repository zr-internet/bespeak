require 'active_support'

ActiveAdmin.register Office do
	form do |f|
		f.inputs name: "Office" do
			f.input :name
			f.input :phone
			f.input :address
			f.input :directions
			f.input :time_zone, :as => :select, :collection => ActiveSupport::TimeZone.us_zones
		end
		f.buttons
	end
end
