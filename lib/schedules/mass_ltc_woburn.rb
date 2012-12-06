module Schedules
	class MassLtcWoburn
		attr_reader :course_type
		attr_reader :office
		attr_reader :times
		attr_reader :duration
		
		def initialize(options)
			@course_type = options[:course_type] || CourseType.where(name: "MA LTC-007").first
			@office = options[:office] || Office.where(name: "Woburn").first
			@times = options[:times] || [Chronic.parse("Tuesday 6:30pm"), Chronic.parse("Saturday 9:00am")]
			@duration = 3.hours + 30.minutes
		end
		
		def next_course(date = Time.now, count = 1)
			courses = []
			week_start = date.beginning_of_week(:sunday)
			while courses.size < count
				week_times = @times.map { |t| week_start.beginning_of_year + (t.wday + week_start.yday - 1).days + t.hour.hours + t.min.minutes }
				week_times.each do |t| 
					if t >= date
						c = @course_type.courses.build
						c.office = office
						c.start = t
						c.end = t + @duration
						courses.push c	
					end
				end
				week_start += 7.days
			end
			courses
		end
		
	end
end
