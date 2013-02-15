require 'spec_helper'

describe "customer_mailer/booking_confirmation" do
	let(:booking) { FactoryGirl.build(:booking, course: FactoryGirl.build(:course, office: FactoryGirl.build(:office, directions: "Left then right"))) }
	before(:each) do
		assign(:booking, booking)
	end
	
	it "has the course name" do
		render
		rendered.should include booking.course_name
	end
	
	it "has the office name" do
		render
		rendered.should include booking.office_name
	end
	
	it "has the course local start_at" do
		render
		rendered.should include booking.course.start_at.in_time_zone(booking.course.office.time_zone).to_formatted_s(:long_ordinal)
	end
	
	it "has the office directions" do
		render
		rendered.should include booking.course.office.directions
	end
end
