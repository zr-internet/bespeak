require 'active_support'
require 'time_zone_ext'

class Office < ActiveRecord::Base
	attr_accessible :address, :name, :phone, :time_zone, :as => :admin

	geocoded_by :address
	after_validation :geocode          # auto-fetch coordinates
	
	has_many					:courses
	
	def time_zone
		zone = read_attribute(:time_zone)
		ActiveSupport::TimeZone.create(zone) if zone.present?
	end
	
	def time_zone=(zone)
		zone = ActiveSupport::TimeZone.from_string(zone) if zone.kind_of? String
		write_attribute(:time_zone, zone.name)
	end
	
	def to_s
		name
	end
end
