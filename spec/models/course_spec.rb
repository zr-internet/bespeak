require 'spec_helper'

describe Course do
	it { should respond_to :start_at }
	it { should respond_to :end_at }
	it { should respond_to :address }
	it { should respond_to :name }
	it { should respond_to :office_name }
	
	it { should respond_to :cost }
	it { should respond_to :description }
	
	it { should belong_to :office }
	it { should belong_to :course_type }
	
	describe "scopes" do
		subject { Course }
		it { should respond_to :available }
		it { should respond_to :upcoming }
	end
	
	describe "caching" do
		let(:course) { FactoryGirl.build_stubbed(:course) }
		
		it { should respond_to :cache_key }
		it "should get a new cache_key when updated" do
			expect { course.touch }.to change { course.cache_key }
		end
		
		describe "for available courses" do
			subject { Course }
			let(:start_at) { Time.now }
			let(:new_start_at) { start_at + 1.month }
			let(:courses) { FactoryGirl.create_list(:course, 3, start_at: Time.now + 2.months) }
			let(:course) { courses.first }

			before(:each) do
				course.start_at = start_at; course.save!
			end
			describe ".available_key" do
				it { should respond_to :available_key }
				it "should change when the the minimum start_at for Course.upcoming changes" do
					expect {
						course.start_at = new_start_at
						course.save!
					}.to change { Course.available_key }
				end
				it "should change when there is a new booking" do
					expect {
						FactoryGirl.create(:booking, course: course)
					}.to change { Course.available_key }
				end
				it "should change when a course is updated" do
					c = FactoryGirl.create(:course, max_occupancy: 1, updated_at: Time.now - 1.day)
					expect {
						c.updated_at = Course.maximum(:updated_at) + 1.second
						c.save
					}.to change { Course.available_key }
				end
			end
		end
	end
end
