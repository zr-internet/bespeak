# 1.9.3-p327 :006 > s = Schedules::Generator.new(timezone: o.time_zone)
# => #<Schedules::Generator:0x007fa81c627f70 @timezone=(GMT-05:00) Eastern Time (US & Canada)> 
# 1.9.3-p327 :007 > p = "Tuesday at 6:30"
# => "Tuesday at 6:30" 
# 1.9.3-p327 :008 > s.times(pattern: p, count: 8)
# => [Tue, 08 Jan 2013 06:30:00 EST -05:00, Tue, 15 Jan 2013 06:30:00 EST -05:00, Tue, 22 Jan 2013 06:30:00 EST -05:00, Tue, 29 Jan 2013 06:30:00 EST -05:00, Tue, 05 Feb 2013 06:30:00 EST -05:00, Tue, 12 Feb 2013 06:30:00 EST -05:00, Tue, 19 Feb 2013 06:30:00 EST -05:00, Tue, 26 Feb 2013 06:30:00 EST -05:00]
module Schedules
	class Generator
		attr_reader :timezone
		
		def initialize(*args)
			options = {timezone: Time.zone}.merge(args.extract_options!)
			@timezone = options[:timezone]
		end
		
		def times(*args)
			options = {pattern: "now", start: timezone.now, count: 1}.merge(args.extract_options!)
			
			times = []
			begin
				Chronic.time_class = self.timezone
			
				times += n_times(options[:pattern], options[:start], options[:count])
			ensure
				Chronic.time_class = Time.zone
			end
			
			return times
		end
		
		private
		def n_times(pattern, start, count)
			times = []
			time = Chronic.parse(pattern, :now => start)
			count.times do |n|
				times << time
				time += increment(pattern)
			end
			times
		end
		
		def increment(pattern)
			1.week
		end
		
		
	end
end