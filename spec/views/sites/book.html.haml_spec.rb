require 'spec_helper'

describe "sites/book" do
	before(:each) do
		assign(:courses, [])
		assign(:course_types, [])
		assign(:offices, [])
	end
	
	it "renderers a #booking element" do
		render
		rendered.should have_selector "#booking"
	end
	
	context "with offices" do
		let(:offices) { FactoryGirl.build_list(:office, 1, name: "Office") }
		before(:each) do
			assign(:offices, offices)
		end

		it "renderers the office names" do
			render
			offices.each { |o| rendered.should include o.name }
		end
	end
	
	context "with course types" do
		let(:course_types) { FactoryGirl.build_list(:course_type, 1, name: "Course Type") }
		before(:each) do
			assign(:course_types, course_types)
		end

		it "renderers the ocourse_types names" do
			render
			course_types.each { |ct| rendered.should include ct.name }
		end
	end
	
	context "with courses" do
	  let(:courses) { CourseDecorator.decorate_collection(FactoryGirl.build_list(:course, 1, id: 1)) }
		before(:each) do
			assign(:courses, courses)
		end
		
		it "renders a tr element for each course" do
			render
			courses.each { |c| rendered.should have_selector("tr[data-course-id='#{c.id}']")}
		end
	end
end