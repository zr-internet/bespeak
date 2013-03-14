require 'spec_helper'

describe PaymentProcess::Processor do
	subject { FactoryGirl.build_stubbed(:payment).extend PaymentProcess::Processor }
	describe "#process!" do
		it { should respond_to :process! }
		
		context "with a valid coupon payment" do
			let(:payment) { FactoryGirl.build_stubbed(:coupon_payment).extend PaymentProcess::Processor }
			let(:code) { "valid coupon code" }
			
			it "should set the token for the payment to the coupon code" do
				expect { 
					payment.process! :coupon_code => code
				}.to change { payment.token }.to(code)
			end
		end
		
		context "with a credit card payment" do
			let(:payment) { FactoryGirl.build_stubbed(:credit_card_payment).extend PaymentProcess::Processor }
			let(:options) { {credit_card_number: 'credit card number', credit_card_expiration_month: "credit card expiration month", credit_card_expiration_year: "credit card expiration year", card_code: 'credit card ccv'} }
			let(:site) do
				FactoryGirl.build_stubbed(:site, :authorize_net).tap do |s|
					payment.booking.stub(site: s)
				end
			end
			
			it "should create a new AuthorizeNet::AIM::Transaction with the site's login and api key" do
				AuthorizeNet::AIM::Transaction.should_receive(:new).with(
					site.payment_processor.login,site.payment_processor.key, anything).and_call_original

				payment.process! :payment_details => options
			end
			
			context "with a nil site" do
				let(:payment) { FactoryGirl.build_stubbed(:credit_card_payment).extend PaymentProcess::Processor }
				let(:options) { {credit_card_number: 'credit card number', credit_card_expiration_month: "credit card expiration month", credit_card_expiration_year: "credit card expiration year", card_code: 'credit card ccv'} }
				before(:each) do
					payment.booking.stub(site: nil)
				end

				it "should create a new AuthorizeNet::AIM::Transaction with the ENV Login and API Key" do
					AuthorizeNet::AIM::Transaction.should_receive(:new).with(
						ENV['AUTHORIZE_NET_LOGIN_ID'], ENV['AUTHORIZE_NET_TRANSACTION_KEY'], anything).and_call_original

					payment.process! :payment_details => options
				end			  
			end
		end
	end
end