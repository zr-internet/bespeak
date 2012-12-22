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