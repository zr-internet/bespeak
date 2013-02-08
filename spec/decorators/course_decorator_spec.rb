require 'spec_helper'

describe CourseDecorator do
	let(:course) { FactoryGirl.build(:course) }
	subject { CourseDecorator.new(course) }
	
	describe "#date" do
		before(:each) do
			course.start_at = Time.local(2013,6,10,1,00)
		end
	  it { should respond_to :date }
		
		it "should return a date based on course's start_at" do
			expect {
				course.start_at = course.start_at + 1.week
			}.to change{subject.date}
		end
		
		it "should return a date formatted like 'day_of_week MM/DD/YY'" do
				subject.date.should =~ /[Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday] \d{1,2}\/\d{1,2}\/\d{2}/
		end
		
		it "should be based on the course's office's time zone" do
			expect {
				subject.office.time_zone = ActiveSupport::TimeZone[subject.office.time_zone.utc_offset/(60*60) - 2]
			}.to change{subject.date}
		end
	end
	
	describe "start_time" do
		before(:each) do
			course.start_at = Time.local(2013,6,10,14,00)
		end
	  it { should respond_to :start_time }
		
		it "should return a time based on course's start_at" do
			expect {
				course.start_at = course.start_at + 1.hour
			}.to change{subject.start_time}
		end
		
		it "should be based on the course's office's time zone" do
			expect {
				subject.office.time_zone = ActiveSupport::TimeZone[subject.office.time_zone.utc_offset/(60*60) - 2]
			}.to change{subject.start_time}
		end
		
	end
	
	describe "end_time" do
		before(:each) do
			course.end_at = Time.local(2013,6,10,14,00)
		end
	  it { should respond_to :end_time }
		
		it "should return a time based on course's end_at" do
			expect {
				course.end_at = course.end_at + 1.hour
			}.to change{subject.end_time}
		end
		
		it "should be based on the course's office's time zone" do
			expect {
				subject.office.time_zone = ActiveSupport::TimeZone[subject.office.time_zone.utc_offset/(60*60) - 2]
			}.to change{subject.end_time}
		end
		
	end
end

