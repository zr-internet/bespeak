module ActiveAdmin::ViewsHelper 
	def revenue_per_month(month_start)
		courses = Course.search({start_at_gteq: month_start, start_at_lt: month_start + 1.month})
		revenue = {paid: Money.new(0), owed: Money.new(0)}
		courses.each do |c|
			revenue[:paid] += c.total_paid
			revenue[:owed] += c.total_owed
		end
		revenue
	end
end