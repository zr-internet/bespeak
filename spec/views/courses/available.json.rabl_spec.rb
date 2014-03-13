require 'spec_helper'

AvailableCourseData = Struct.new(:courses, :offices, :course_types)

describe "courses/available.json.rabl" do	
	  let(:courses) { [] }
		let(:course_types) { [] }
		let(:offices)  { [] }
		let(:available_data) do
			AvailableCourseData.new(courses, offices, course_types)
		end
		
		before(:each) do
			assign(:courses, courses)
			assign(:available_data, available_data);
			render({template: 'courses/available', formats: :json, handlers: :rabl})
		end
		
		subject { rendered }
		
		it { pending; should_not be_empty }
		it { pending; should have_json_size(0).at_path("courses") }
		it { pending; should have_json_size(0).at_path("course_types") }
		it { pending; should have_json_size(0).at_path("offices") }
		
	
	context "with an office" do
		let(:office) { FactoryGirl.build(:office) }
		let(:offices) { [office] }
		before(:each) do
			render({template: 'courses/available', formats: :json, handlers: :rabl})
		end
		
		
		subject { rendered }
		it { pending; debugger; should include office.name }
		it { pending; should have_json_size(1).at_path("offices") }
	end
	
	context "with a course_type" do
		let(:course_type) { FactoryGirl.build(:course_type) }
		let(:course_types) { [course_type] }
		before(:each) do
			render({template: 'courses/available', formats: :json, handlers: :rabl})
		end


		subject { rendered }
		it { pending; should include course_type.name }
		it { pending; should have_json_size(1).at_path("course_types") }
	end
	
	context "with a course" do
		let(:course) { FactoryGirl.build_stubbed(:course) }
		let(:courses) { [course, FactoryGirl.build_stubbed(:course)] }
		before(:each) do
			render({template: 'courses/available', formats: :json, handlers: :rabl})
		end


		subject { rendered }
		it { should include course.id.to_s }
		it { should include course.start_at.to_i.to_s }
		it { should include course.start_at.in_time_zone(course.office.time_zone).utc_offset.to_s }
		it { pending; should have_json_size(1).at_path("courses") }
	end

end