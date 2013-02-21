class CourseDecorator < Draper::Decorator
  delegate_all

	def date
		source.start_at.in_time_zone(source.office.time_zone).strftime("%A %-m/%e/%y")
	end

	def start_time
		source.start_at.in_time_zone(source.office.time_zone).strftime("%-l:%M %P")
	end
	
	def end_time
		source.end_at.in_time_zone(source.office.time_zone).strftime("%-l:%M %P")
	end
	
	def start_date_time
		[date,start_time].join(' @ ')
	end
end