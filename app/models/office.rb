require 'active_support'

class Office < ActiveRecord::Base
	attr_accessible :address, :name, :phone, :time_zone, :as => :admin

	geocoded_by :address
	after_validation :geocode          # auto-fetch coordinates
	
	has_many					:courses
	
	def time_zone
		ActiveSupport::TimeZone.create(read_attribute(:time_zone))
	end
	
	def time_zone=(zone)
		write_attribute(:time_zone, zone.name)
	end
	
	def to_s
		name
	end
end
