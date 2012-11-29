class Booking < ActiveRecord::Base
  attr_accessible	:attendees, :course_id, :customer_id, :as => [:customer, :admin]

	belongs_to			:customer
	belongs_to			:course
	has_many				:payments
	
	validates_associated :payments
	
	monetize :owed_cents
	def owed_cents
		attendees * course.cost_cents - paid_cents
	end
	
	monetize :paid_cents
	def paid_cents
		payments.sum(:amount_cents)
	end
end
