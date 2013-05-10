require 'validates_associated_with_error_messages'

class Booking < ActiveRecord::Base
  attr_accessible	:attendees, :course_id, :customer_id, :site_id, :as => [:customer, :admin]

	has_one					:site, through: :course
	belongs_to			:customer, :inverse_of => :bookings
	belongs_to			:course
	has_many				:payments, :inverse_of => :booking
	
	validates	:customer, :presence => true
	validates	:course, :presence => true
	
	validates_associated_with_error_messages :payments
	
	monetize :owed_cents
	def owed_cents
		attendees * course.cost_cents - paid_cents
	end
	
	monetize :paid_cents
	def paid_cents
		payments.reduce(0) { |total, payment| total += payment.amount_cents }
	end
	
	delegate :email, :to => :customer, :prefix => true, :allow_nil => true
	delegate :email_configuration, :to => :site, :prefix => true, :allow_nil => true
	delegate :name, :start_at, :end_at, :address, :cost, :to => :course, :prefix => true, :allow_nil => true
	delegate :office_name, :to => :course, :prefix => false, :allow_nil => true
	delegate :office_time_zone, :to => :course, :prefix => false, :allow_nil => true
	def office_address
		course_address
	end
	def office_directions
		course.office.directions
	end
	
	def to_label
		[ id, course.to_s, customer_email, attendees ].join('-')
	end
end
