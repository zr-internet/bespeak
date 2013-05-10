# Read about factories at https://github.com/thoughtbot/factory_girl

require 'active_support'
require 'time_zone_ext'

unless defined?(EmailerDetails)
	class EmailerDetails < Struct.new(:site_email_configuration, :course_name, :customer_email, :office_name, :office_time_zone, :course_start_at, :office_address, :office_directions)
	end
end

FactoryGirl.define do
  factory :emailer_details do
    site_email_configuration	FactoryGirl.build(:email_configuration)
		course_name								"Test Course Name"
		customer_email						FactoryGirl.generate(:email)
		office_name								"Test Office Name"
		office_time_zone					ActiveSupport::TimeZone.from_string("Eastern Time (US & Canada)")
		course_start_at						{ Time.now + 1.day }
		office_address						"Test "
		office_directions					"Test Directions\nTurn left, then go straight"
  end
end
