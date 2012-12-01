class Course < ActiveRecord::Base
  attr_accessible :course_type_id, :end, :max_occupancy, :office_id, :start, :as => :admin

	belongs_to 	:office
	belongs_to 	:course_type
	
	has_many		:bookings
	
	def to_s
		[name, office.name, start.strftime("%F - %l:%M %P")].join(", ")
	end
	
	delegate :cost, :cost_cents, :description, :name, :to => :course_type
	
	scope :upcoming, lambda { where('start >= ?', Time.now) }
	# TODO: Replace with code like: http://blog.donwilson.net/2011/11/constructing-a-less-than-simple-query-with-rails-and-arel/
	scope :available, -> { joins("LEFT OUTER JOIN bookings ON bookings.course_id = courses.id").group("courses.id, courses.course_type_id, courses.start, courses.end, courses.office_id, courses.max_occupancy, courses.created_at, courses.updated_at").having("COALESCE(SUM(bookings.attendees), 0) < courses.max_occupancy").select("courses.id, courses.course_type_id, courses.start, courses.end, courses.office_id, courses.max_occupancy, courses.created_at, courses.updated_at, SUM(bookings.attendees)") }
end