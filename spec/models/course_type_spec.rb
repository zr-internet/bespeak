require 'spec_helper'

describe CourseType do
	it { should respond_to :name }
	it { should respond_to :description }
	it { should respond_to :cost }
end
