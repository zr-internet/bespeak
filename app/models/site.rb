class Site < ActiveRecord::Base
  attr_accessible 	:name, :token, :confirmation_url, :payment_processor_attributes, :email_configuration_attributes, :form_attributes, :as => :admin
	has_many					:courses, inverse_of: :site
	has_many					:offices, inverse_of: :site
	has_many					:course_types, inverse_of: :site
	has_many					:bookings, through: :courses, inverse_of: :site
	has_many					:customers, inverse_of: :site
	has_many					:payments, through: :bookings, inverse_of: :site
	has_one						:payment_processor, inverse_of: :site
	has_one						:email_configuration, inverse_of: :site
	has_one						:form, inverse_of: :site
	validates					:token, uniqueness: true, presence: true
	
	accepts_nested_attributes_for	:payment_processor
	accepts_nested_attributes_for	:email_configuration
	accepts_nested_attributes_for	:form
	
	before_validation do |site|
		unless site.token?
			site.token = Site.generate_token
		end
	end
	
	def display_name
		name
	end
	
	def to_param
		token
	end
	
	def available_key
		"site-#{self.token}-courses-available-" + Digest::MD5.hexdigest("#{latest_course_updated_at.try(:to_i)}-#{courses_count}-#{next_course_start_at.try(:to_i)}-#{latest_booking_updated_at.try(:to_i)}-#{bookings_count}")
	end
	
	def courses_count
		self.courses.count
	end
	
	def bookings_count
		self.bookings.count
	end
	
	def next_course_start_at
		courses.upcoming.minimum(:start_at)
	end
	
	def latest_course_updated_at
		courses.maximum(:updated_at)
	end
	
	def latest_booking_updated_at
		bookings.maximum(:updated_at)
	end
	
	def self.generate_token
		begin
			token = SecureRandom.urlsafe_base64(16)[0,16]
		end while Site.where(:token => token).exists?
		token
	end
	
end
