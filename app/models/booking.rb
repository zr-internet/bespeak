class Booking < ActiveRecord::Base
  attr_accessible	:attendees, :course_id, :customer_id, :as => [:customer, :admin]

	belongs_to			:customer
	belongs_to			:course
	has_many				:payments, :inverse_of => :booking
	
	validates_associated :payments
	
	monetize :owed_cents
	def owed_cents
		attendees * course.cost_cents - paid_cents
	end
	
	monetize :paid_cents
	def paid_cents
		payments.sum(:amount_cents)
	end
	
	delegate :email, :to => :customer, :prefix => true, :allow_nil => true
	delegate :name, :time, :address, :to => :course, :prefix => true, :allow_nil => true
	delegate :office_name, :to => :course, :prefix => false, :allow_nil => true
end
