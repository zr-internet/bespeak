require 'spec_helper'

describe Emailer::MandrillPlugin, :vcr do
	subject { FactoryGirl.build(:emailer_details).extend Emailer::MandrillPlugin }
	describe "#send_confirmation" do
		it { should respond_to :send_confirmation }
		
		context "with valid Email Configuration" do
			before(:each) do
				subject.site_email_configuration = FactoryGirl.build(:email_configuration)
			end
			
			it "should create a new Mandrill::API with the Email Configuration's key" do
				Mandrill::API.should_receive(:new).with(subject.site_email_configuration.key, Rails.env.test?).and_return(double(Mandrill::API).as_null_object)
				subject.send_confirmation
			end

			context "Mandrill API implementation" do
			  let!(:api) { Mandrill::API.new(subject.site_email_configuration.key, true) }
				before(:each) do
				  Mandrill::API.stub(:new).with(subject.site_email_configuration.key, Rails.env.test?).and_return( api)
				end
				
				it "should call the mandrill api object's messages.send_template" do
					pending "Need to figure out how to test this"
					api.should_receive(:messages).and_return(api.messages)
					api.messages.should_receive(:send_template)
					subject.send_confirmation
				end
			end
		end
	end
	
	describe "#send_reminder" do
		it { should respond_to :send_reminder }
	end
end