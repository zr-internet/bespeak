require 'spec_helper'

describe Booking do
	subject { FactoryGirl.build_stubbed(:booking) }
	
	it { should respond_to :customer_email }
	it { should respond_to :course_name }
	it { should respond_to :course_start_at }
	it { should respond_to :course_address }
	it { should respond_to :office_address }
	it { should respond_to :course_cost }
	it { should respond_to :office_name }
	it { should respond_to :office_time_zone }
	it { should respond_to :attendees }
	
	it { should validate_presence_of :customer }
	
	it { should have_many :payments }
	it { should belong_to :customer }
	it { should have_one :site }	
	
	describe "#to_label" do
		let(:booking) { FactoryGirl.build_stubbed(:booking) }
		it { should respond_to :to_label }
		it "should return id-course.to_s-customeremail-attendees" do
			booking.to_label.should == [ booking.id, booking.course.to_s, booking.customer_email, booking.attendees ].join('-')
		end
	end

	describe "#site_email_configuration" do
	  it { should respond_to :site_email_configuration }
		context "with a site" do
			before(:each) do
				subject.stub(site: mock_model(Site))
			end
			it "should return the site's email configuration" do
				subject.site.should_receive(:email_configuration).once.and_return(double("email config"))
				subject.site_email_configuration
			end
		end
	end

	
	
	context "caching" do
		context "#cache_key" do
			it { should respond_to :cache_key }
		end
	end
end
