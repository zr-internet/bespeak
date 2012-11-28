class Booking < ActiveRecord::Base
  attr_accessible	:attendees, :course_id, :customer_id, :as => [:customer, :admin]

	belongs_to			:customer
	belongs_to			:course
	
	monetize :owed_cents
	def owed_cents
		attendees * course.cost_cents
	end
	
	monetize :paid_cents
	def paid_cents
		0
	end
end
