class Office < ActiveRecord::Base
	attr_accessible :address, :name, :phone, :as => :admin

	geocoded_by :address
	after_validation :geocode          # auto-fetch coordinates
	
	has_many					:courses
end
