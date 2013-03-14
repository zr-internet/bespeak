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

  end
end
