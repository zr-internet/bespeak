class Course < ActiveRecord::Base
  attr_accessible :course_type_id, :end_at, :max_occupancy, :office_id, :start_at, :site_id, :as => :admin

	belongs_to	:site, 				inverse_of: :courses
	belongs_to 	:office, 			inverse_of: :courses
	belongs_to 	:course_type,	inverse_of: :courses
	
	has_many		:bookings,		inverse_of: :course
	
	def to_s
		[name, office.name, start_at.in_time_zone(office.time_zone).strftime("%F - %l:%M %P")].join(", ")
	end
	alias_method :to_label, :to_s
	
	def attendee_count
		bookings.sum(:attendees)
	end
	
	def open?
		attendee_count < (max_occupancy || 0) && start_at >= Time.zone.now
	end
	def closed?
		!open?
	end
	
	monetize :total_paid_cents
	def total_paid_cents
		self.bookings.reduce(0) { |total, b| total += b.paid_cents }
	end
	
	monetize :total_owed_cents
	def total_owed_cents
		(self.cost_cents * self.attendee_count) - self.total_paid_cents
	end
	
	delegate :cost, :cost_cents, :description, :name, :to => :course_type
	delegate :address, :to => :office
	delegate :name, :time_zone, :to => :office, :prefix => true, :allow_nil => true
	
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