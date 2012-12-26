# monkey patch ActiveSupport::TimeZone to allow us to create a TimeZone from a text string representation
# Basically we want:
# ActiveSupport::TimeZone["UTC"] == ActiveSupport::TimeZone.ParseFromString(ActiveSupport::TimeZone["UTC"].to_s)

require 'active_support'

module ActiveSupport
	class TimeZone
		def self.from_string(string)
			# is string to_s representation of a TimeZone?
			name = /\(GMT[+-]\d{2}:\d{2}\)\s(.+)/.match(string)
			
			zone = nil
			if name.present?
				zone = ActiveSupport::TimeZone[name[1]]
			else #assume string is a timezone name
				zone = ActiveSupport::TimeZone[string]
			end
				
			raise ArgumentError, "invalid argument to TimeZone.from_string: #{string.inspect}" unless zone.present?
			
			zone
		end
	end
end