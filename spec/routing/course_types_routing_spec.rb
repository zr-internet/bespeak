require "spec_helper"

describe CourseTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/course_types").should route_to("course_types#index")
    end

    it "routes to #new" do
      get("/course_types/new").should route_to("course_types#new")
    end

    it "routes to #show" do
      get("/course_types/1").should route_to("course_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/course_types/1/edit").should route_to("course_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/course_types").should route_to("course_types#create")
    end

    it "routes to #update" do
      put("/course_types/1").should route_to("course_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/course_types/1").should route_to("course_types#destroy", :id => "1")
    end

  end
end
