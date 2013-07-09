require 'spec_helper'

describe CourseTypesController do

  describe "GET index.json" do
		context "with a valid site_id" do
		  let(:site) { FactoryGirl.build_stubbed(:site).tap do |s| Site.stub(:find_by_token).with(s.token).and_return(s) end }

			context "as raw json" do
		    it "assigns site.course_types as @course_types" do
					site.should_receive(:course_types).and_return(:site_course_types)
		      get :index, format: "json", site_id: site.token
		      assigns(:course_types).should eq(:site_course_types)
		    end  
			end
		end
  end
end
