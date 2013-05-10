require 'spec_helper'

describe Course do
	it { should respond_to :start_at }
	it { should respond_to :end_at }
	it { should respond_to :address }
	it { should respond_to :name }
	it { should respond_to :office_name }
	it { should respond_to :office_time_zone }
	
	it { should respond_to :cost }
	it { should respond_to :description }
	
	it { should belong_to :office }
	it { should belong_to :course_type }
	it { should belong_to :site }
	
	describe "#attendee_count" do
		context "with no bookings" do
			subject { FactoryGirl.build(:course) }
			it "should be 0" do
				subject.attendee_count.should == 0
			end		  
		end
		context "with a single booking for 1 person" do
		  subject { FactoryGirl.create(:booking, attendees: 1).course }
			it "should be 1" do
				subject.attendee_count.should == 1
			end
		end
		context "with a single booking for 2 people" do
		  subject { FactoryGirl.create(:booking, attendees: 2).course }
			it "should be 2" do
				subject.attendee_count.should == 2
			end
		end
		context "with a 2 bookings each for 1 person" do
		  subject { FactoryGirl.create(:course).tap do |c| FactoryGirl.create_list(:booking, 2, course: c) end }
			
			it "should be 2" do
				subject.attendee_count.should == 2
			end
		end
	end
	
	describe "#open?" do
		it { should respond_to :open?}
		context "with course in the future" do
		  subject { FactoryGirl.build(:course, start_at: Time.now + 1.minute) }
			context "with attendee count < max_occupancy" do
			  before(:each) do 
					subject.max_occupancy = subject.attendee_count + 1
				end
				
				it "should return true" do
					subject.should be_open
				end
			end
			context "with attendee count >= max_occupancy" do
				it "should return false" do
					subject.should_not be_open
				end
			end
		end
		context "with course in the past or now" do
			subject { FactoryGirl.build(:course, start_at: Time.now) }
			it "should return false" do
			  subject.should_not be_open
			end
		end
	end
	
	describe "#closed?" do
		it "should return the opposite of #open?" do
			subject.closed?.should == !subject.open?
		end
	end
	
	describe "#to_label" do
		let(:course) { FactoryGirl.build_stubbed(:course) }
		it { should respond_to :to_label }
		it "should return course.to_s" do
			course.to_label.should == course.to_s
		end
	end
	
	context "revenue reporting methods" do
		describe "#total_paid" do
			context "with a booking paid by credit card" do
				let(:payment) { FactoryGirl.create(:payment, :credit_card, amount: Money.new(1000)) }
				subject { payment.booking.course.reload }
				
				it { subject.total_paid.should == payment.amount }
			end
			
			context "with a booking paid by coupon" do
				let(:payment) { FactoryGirl.create(:payment, :coupon, amount: Money.new(1000)) }
				subject { payment.booking.course.reload }
				
				it { subject.total_paid.should == payment.amount }
			end
			
			context "with a booking paid by cash" do
				let(:payment) { FactoryGirl.create(:payment, :cash) }
				subject { payment.booking.course.reload }
				
				it { subject.total_paid.should == Money.new(0) }
			end
		end
		describe "#total_owed" do
			context "with a booking paid by credit card" do
				let(:payment) { FactoryGirl.create(:payment, :credit_card, amount: Money.new(1000)) }
				subject { payment.booking.course.reload }
				
				it { subject.total_owed.should == subject.cost - payment.amount }
			end
			
			context "with a booking paid by coupon" do
				let(:payment) { FactoryGirl.create(:payment, :coupon, amount: Money.new(1000)) }
				subject { payment.booking.course.reload }
				
				it { subject.total_owed.should == subject.cost - payment.amount }
			end
			
			context "with a booking paid by cash" do
				let(:payment) { FactoryGirl.create(:payment, :cash) }
				subject { payment.booking.course.reload }
				
				it { subject.total_owed.should == subject.cost }
			end
		end
	end
	
	
	
	
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
