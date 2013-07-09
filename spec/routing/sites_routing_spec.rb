require "spec_helper"

describe CoursesController do
  describe "routing" do

		it "routes to #book" do
			get("/book").should route_to("sites#old_book")
		end
		
		it "routes to #formstack" do
			get("/form").should route_to("sites#old_formstack")
		end
		
		it "routes /sites/:id/form to #formstack" do
			get("/sites/SITE_TOKEN/form").should route_to(controller: "sites", action: "formstack", id: "SITE_TOKEN")
		end
		
		it "routes /sites/:id/courses to CourseController#index" do
			get("/sites/SITE_TOKEN/courses").should route_to(controller: "courses", action: "index", site_id: "SITE_TOKEN")
		end
		
		it "routes /sites/:id/offices to OfficeController#index" do
			get("/sites/SITE_TOKEN/offices").should route_to(controller: "offices", action: "index", site_id: "SITE_TOKEN")
		end
		
		it "routes /sites/:id/course_types to CourseTyoeController#index" do
			get("/sites/SITE_TOKEN/course_types").should route_to(controller: "course_types", action: "index", site_id: "SITE_TOKEN")
		end

  end
end
