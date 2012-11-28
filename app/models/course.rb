class Course < ActiveRecord::Base
  attr_accessible :course_type_id, :end, :max_occupancy, :office_id, :start, :as => :admin

	belongs_to 	:office
	belongs_to 	:course_type
	
	has_many		:bookings
	
	def to_s
		[name, office.name, start.strftime("%F - %l:%M %P")].join(", ")
	end
	
	delegate :cost, :cost_cents, :description, :name, :to => :course_type
end
