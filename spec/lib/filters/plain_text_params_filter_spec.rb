require 'spec_helper'
require	'plain_text_params_filter'

describe PlainTextParamsFilter do
	let(:filter) { PlainTextParamsFilter}
	subject{ filter }

	it { should respond_to(:filter).with(1).argument }	

	context ".filter" do
		let!(:controller_standin) {
			klass = Class.new do
				def params
					@params ||= {}
				end
			end
			klass.new
		}
		before(:each) do
			controller_standin.stub(request: double().tap { |r| r.stub(content_type: "invalid", raw_post: nil) })
		end
		
		context "when request.content_type is text/plain" do
			before(:each) do
				controller_standin.request.stub(content_type: 'text/plain')
			end
		  
			context "when request.raw_post is url encoded data (email=test@example.com)" do
			  before(:each) do
					controller_standin.request.stub(raw_post: "email=test@example.com")
				end
				it "sets params['email'] to 'test@example.com'" do
					filter.filter(controller_standin)
					controller_standin.params["email"].should == "test@example.com"
			  end
			end
		end
		context "when request.content_type is not text/plain" do
			before(:each) do
				controller_standin.request.stub(content_type: 'text/fancy')
			end

			context "when request.raw_post is url encoded data (email=test@example.com)" do
			  before(:each) do
					controller_standin.request.stub(raw_post: "email=test@example.com")
				end
				it "doesn't change params" do
					expect { filter.filter(controller_standin) }.to_not change { controller_standin.params }
			  end
			end
		end
	end
end