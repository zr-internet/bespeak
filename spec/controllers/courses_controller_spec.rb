require 'spec_helper'

describe CoursesController do

  describe "GET available.json" do
		context "with a valid site_id" do
		  let(:site) { FactoryGirl.build_stubbed(:site).tap do |s| Site.stub(:find_by_token).with(s.token).and_return(s) end }
			let(:available_courses) do
				double("Course.available").tap do |courses|
					courses.stub(:order).and_return(courses)
				end
			end

			context "as raw json" do
		    it "assigns Course.available as @courses" do			
					site.courses.should_receive(:available).and_return(available_courses)
		      get :available, format: "json", site_id: site.token
		      assigns(:courses).should eq(available_courses)
		    end  
			end
		end
  end
end
