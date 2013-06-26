require 'spec_helper'

describe Site do
	context 'class methods' do
		subject { Site }
		describe ".generate_token" do
			it { should respond_to :generate_token }
			it "should generate a token with a length of 16" do
				subject.generate_token.length.should == 16
			end

			it "should generate an unused token" do
				pending "Need to figure out how to test this"
			end
			
		end
	end
	
	it { should respond_to :name }
	describe "#display_name" do
		it { should respond_to :display_name }
		it "should return the site's name" do
			subject.name = "Test Site Name"
			subject.display_name.should == subject.name
		end
	end
	
	it { should respond_to :token }
	it "should return the token for param" do
	  subject.token = "token"
		subject.to_param.should == subject.token
	end
	
	it { should have_many :courses }
	it { should have_many :course_types }
	it { should have_many :bookings }
	it { should have_many :payments }
	it { should have_many :customers }
	it { should have_many :offices }
	
	it { should respond_to	:confirmation_url }
	it { should respond_to	:confirmation_url= }
	
	it { should have_one :payment_processor }
	it { should accept_nested_attributes_for :payment_processor }
	it { should have_one :email_configuration }
	it { should accept_nested_attributes_for :email_configuration }
	it { should have_one :form }
	it { should accept_nested_attributes_for :form }
	
	context "callbacks" do
		describe "before valiation" do
			context "without a token set" do
				it "should set to token to a Site.generate_token result" do
					subject.token = nil
					Site.should_receive(:generate_token).once.and_return('test token')
					subject.valid?
					subject.token.should == 'test token'
				end
			end
			context "with a token" do
				it "should not change the token" do
					subject.token = 'foo'
					expect {
						subject.valid?
					}.to_not change{subject.token}
				end
			end
		end
	end
	
	describe "caching" do
		let(:site) { FactoryGirl.build_stubbed(:site) }
				
		describe "for available courses" do
			subject { site }
			let(:upcoming_time) { Time.now + 1.minute  }
			let(:changed_time) { upcoming_time + 1.month }
			let(:initial_count) { 1 }
			let(:changed_count) { initial_count + 1 }
			before(:each) do
				subject.stub(:courses_count).and_return(initial_count)
				subject.stub(:bookings_count).and_return(initial_count)
				subject.stub(:next_course_start_at).and_return(upcoming_time)
				subject.stub(:latest_booking_updated_at).and_return(upcoming_time)
				subject.stub(:latest_course_updated_at).and_return(upcoming_time)
			end

			describe ".available_key" do
				it { should respond_to :available_key }
				it "changes when #courses_count changes" do
					expect {
						subject.stub(:courses_count).and_return(changed_count)
					}.to change { subject.available_key }
				end
				it "changes when #bookings_count changes" do
					expect {
						subject.stub(:bookings_count).and_return(changed_count)
					}.to change { subject.available_key }
				end
				it "changes when #next_course_start_at changes" do
					expect {
						subject.stub(:next_course_start_at).and_return(changed_time)
					}.to change { subject.available_key }
				end
				it "changes when #latest_booking_updated_at changes" do
					expect {
						site.stub(:latest_booking_updated_at).and_return(changed_time)
					}.to change { subject.available_key }
				end
				it "changes when #latest_course_updated_at changes" do
					expect {
						site.stub(:latest_course_updated_at).and_return(changed_time)
					}.to change { subject.available_key }
				end
			end
		end
	end

	it { should respond_to :courses_count }	
	describe "#courses_count" do
		let(:site) { Site.new }
		it "delegates to #courses.count" do
			site.courses.should_receive(:count)
			site.courses_count
		end
	end
	
	it { should respond_to :bookings_count }
	describe "#bookings_count" do
		let(:site) { Site.new }
		it "delegates to #bookings.count" do
			site.bookings.should_receive(:count)
			site.bookings_count
		end
	end
	it { should respond_to :next_course_start_at }
	describe "#next_course_start_at" do
		context "with no courses" do
			before(:each) do
				subject.courses.delete_all
			end
		  
			it "returns a nil" do
				subject.next_course_start_at.should be_nil
			end
		end
		context "with courses" do
		  let!(:course) { FactoryGirl.create(:course, site: subject) }
			context "with courses.maximum(:start_at) in the past" do
			  before(:each) do
			    course.start_at = 1.day.ago
					course.save
			  end

				it "returns a nil" do
					subject.next_course_start_at.should be_nil
				end
			end
			context "with courses in the future" do
				before(:each) do
					course.start_at = 1.day.from_now
					course.save
				end

				context "with one course in the future" do
					it "returns the courses start_at" do
						subject.next_course_start_at.should == course.start_at
					end
				end
				context "with multiple courses in the future" do
				  let!(:second_course) { FactoryGirl.create(:course, site: subject, start_at: course.start_at + 1.day) }
					
					it "returns the earliest upcoming course" do
						subject.next_course_start_at.should == course.start_at
					end
				end
			
			end
		end
	end
	
	it { should respond_to :latest_course_updated_at }
	describe "#latest_course_updated_at" do
		context "with no courses" do
			before(:each) do
				subject.courses.delete_all
			end
		  
			it "returns a nil" do
				subject.latest_course_updated_at.should be_nil
			end
		end
		context "with courses" do
			let!(:course) { FactoryGirl.create(:course, site: subject) }
			
			context "with one course" do
				it "returns the course's updated_at" do
					subject.latest_course_updated_at.should == course.updated_at
				end
			end
			
			context "with two courses" do
				let!(:second_course) { FactoryGirl.create(:course, site: subject, updated_at: course.updated_at + 1.minute) }

				it "returns the most recently update courses's updated_at" do
					subject.latest_course_updated_at.should == second_course.updated_at
				end
			end
			
		end
	end
	
	it { should respond_to :latest_booking_updated_at }
	describe "#latest_booking_updated_at" do
		context "with no bookings" do
			before(:each) do
				subject.bookings.delete_all
			end
		  
			it "returns a nil" do
				subject.latest_booking_updated_at.should be_nil
			end
		end
		context "with bookings" do
			let(:course) { FactoryGirl.create(:course, site: subject) }
			let!(:booking) { FactoryGirl.create(:booking, course: course) }
			
			context "with one booking" do
				it "returns the booking's updated_at" do
					subject.latest_booking_updated_at.should == booking.updated_at
				end
			end
			
			context "with two bookings" do
				let!(:second_booking) { FactoryGirl.create(:booking, course: course, updated_at: booking.updated_at + 1.minute) }

				it "returns the most recently update booking's updated_at" do
					subject.latest_booking_updated_at.should == second_booking.updated_at
				end
			end
			
		end
	end
end