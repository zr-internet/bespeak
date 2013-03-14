require 'spec_helper'

describe CourseType do
	it { should respond_to :name }
	it { should respond_to :description }
	it { should respond_to :cost }
	
	it { should belong_to :site }
	
	describe "#to_label" do
		let(:course_type) { FactoryGirl.build_stubbed(:course_type) }
		it { should respond_to :to_label }
		it "should return course_type.name" do
			course_type.to_label.should == course_type.name
		end
	end
end
