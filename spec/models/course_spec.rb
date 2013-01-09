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
end
