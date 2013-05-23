module ActiveAdmin::ViewsHelper 
	def revenue_per_month(month_start)
		courses = Course.includes(:course_type, bookings: [:payments]).search({start_at_gteq: month_start, start_at_lt: month_start + 1.month})
		revenue = {paid: Money.new(0), owed: Money.new(0)}
		courses.each do |c|
			revenue[:paid] += c.total_paid
			revenue[:owed] += c.total_owed
		end
		revenue
	end
	
	def revenue_by_site(site, start_at, end_at)
		courses = site.courses.includes(:course_type, bookings: [:payments]).search({start_at_gteq: start_at, start_at_lt: end_at})
		revenue = {paid: Money.new(0), owed: Money.new(0)}
		courses.each do |c|
			revenue[:paid] += c.total_paid
			revenue[:owed] += c.total_owed
		end
		revenue
	end
end