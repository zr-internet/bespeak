require 'spec_helper'

describe CoursesController do

  describe "GET available.json" do
    it "assigns Course.available as @courses" do
			available_courses = double("Course.available")
			available_courses.stub(:order) { available_courses }
			
			Course.should_receive(:available).and_return(available_courses)
      get :available, format: "json"
      assigns(:courses).should eq(available_courses)
    end
  end

end
