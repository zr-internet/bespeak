require 'spec_helper'

describe Booking do
	subject { FactoryGirl.build_stubbed(:booking) }
	
	it { should respond_to :customer_email }
	it { should respond_to :course_name }
	it { should respond_to :course_time }
	it { should respond_to :course_address }
	it { should respond_to :office_name }
	
	it { should validate_presence_of :customer }
end
