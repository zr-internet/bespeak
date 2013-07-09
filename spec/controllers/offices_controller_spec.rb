require 'spec_helper'

describe OfficesController do

  describe "GET index.json" do
		context "with a valid site_id" do
		  let(:site) { FactoryGirl.build_stubbed(:site).tap do |s| Site.stub(:find_by_token).with(s.token).and_return(s) end }

			context "as raw json" do
		    it "assigns site.offices as @offices" do
					site.should_receive(:offices).and_return(:site_offices)
		      get :index, format: "json", site_id: site.token
		      assigns(:offices).should eq(:site_offices)
		    end  
			end
		end
  end
end
