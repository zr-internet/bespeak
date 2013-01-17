require 'spec_helper'

describe Booking do
	subject { FactoryGirl.build_stubbed(:booking) }
	
	it { should respond_to :customer_email }
	it { should respond_to :course_name }
	it { should respond_to :course_start_at }
	it { should respond_to :course_address }
	it { should respond_to :course_cost }
	it { should respond_to :office_name }
	
	it { should validate_presence_of :customer }
	
	it { should have_many :payments }
	it { should belong_to :customer }
	
	context "caching" do
		context "#cache_key" do
			it { should respond_to :cache_key }
		end
	end
end
