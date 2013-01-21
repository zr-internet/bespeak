require 'spec_helper'
require	'plain_text_params_filter'
require 'uri'

describe PlainTextParamsFilter do
	let(:filter) { PlainTextParamsFilter}
	subject{ filter }
	let(:credit_card_number) { 'test+card+number' }
	let(:credit_card_post) { 
		"email=test%40example.com&payment_method=credit_card&name=Yosem+Sweet&payment_details%5Bcredit_card_number%5D=#{credit_card_number}&payment_details%5Bcredit_card_expiration_month%5D=03&payment_details%5Bcredit_card_expiration_year%5D=16&payment_details%5Bcredit_card_ccv%5D=2334"
	}

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
			context "when request.raw_post is a booking post with credit card data" do
			  before(:each) do
					controller_standin.request.stub(raw_post: credit_card_post)
				end
				
				it "sets params['email'] to 'test@example.com'" do
					filter.filter(controller_standin)
					controller_standin.params["email"].should == "test@example.com"
			  end
			
				it "sets params['payment_details'] to a hash" do
					filter.filter(controller_standin)
					controller_standin.params["payment_details"].should be_kind_of Hash
				end
				
				it "sets params['payment_details'] to include the credit card number" do
					filter.filter(controller_standin)
					controller_standin.params["payment_details"]['credit_card_number'].should == credit_card_number.gsub(/\+/, ' ')
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