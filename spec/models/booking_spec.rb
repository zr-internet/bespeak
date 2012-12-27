require 'spec_helper'

describe Booking do
	it { should respond_to :customer_email }
	it { should respond_to :course_name }
	it { should respond_to :course_time }
	it { should respond_to :course_address }
	it { should respond_to :office_name }
end
