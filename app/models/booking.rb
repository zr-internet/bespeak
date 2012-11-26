class Booking < ActiveRecord::Base
  attr_accessible	:attendees, :course_id, :customer_id, :as => [:customer, :admin]

	belongs_to			:customer
	belongs_to			:course
end
