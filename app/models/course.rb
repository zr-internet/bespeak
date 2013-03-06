class Course < ActiveRecord::Base
  attr_accessible :course_type_id, :end_at, :max_occupancy, :office_id, :start_at, :as => :admin

	belongs_to 	:office
	belongs_to 	:course_type
	
	has_many		:bookings
	
	def to_s
		[name, office.name, start_at.in_time_zone(office.time_zone).strftime("%F - %l:%M %P")].join(", ")
	end
	def to_label
		self.to_s
	end
	
	def attendee_count
		bookings.sum(:attendees)
	end
	
	def open?
		attendee_count < (max_occupancy || 0) && start_at >= Time.zone.now
	end
	def closed?
		!open?
	end
	
	delegate :cost, :cost_cents, :description, :name, :to => :course_type
	delegate :address, :to => :office
	delegate :name, :to => :office, :prefix => true, :allow_nil => true
	
	scope :upcoming, lambda { where('start_at >= ?', Time.zone.now) }
	# TODO: Replace with code like: http://blog.donwilson.net/2011/11/constructing-a-less-than-simple-query-with-rails-and-arel/
	def self.available
		Rails.cache.fetch available_key do
			upcoming.joins("LEFT OUTER JOIN bookings ON bookings.course_id = courses.id").group("courses.id, courses.course_type_id, courses.start_at, courses.end_at, courses.office_id, courses.max_occupancy, courses.created_at, courses.updated_at").having("COALESCE(SUM(bookings.attendees), 0) < courses.max_occupancy").select("courses.id, courses.course_type_id, courses.start_at, courses.end_at, courses.office_id, courses.max_occupancy, courses.created_at, courses.updated_at, SUM(bookings.attendees)")
		end
	end
	
	def self.available_key
		"course-available-" + Digest::MD5.hexdigest("#{Course.maximum(:updated_at).try(:to_i)}-#{Course.count}-#{upcoming.minimum(:start_at).try(:to_i)}-#{Booking.minimum(:updated_at).try(:to_i)}-#{Booking.count}")
	end
	
	def cache_key
		"course-" + Digest::MD5.hexdigest("#{id}-#{updated_at.try(:to_i)}-#{start_at.try(:to_i)}-#{end_at.try(:to_i)}-#{max_occupancy}-#{course_type_id}-#{office_id}")
	end
end