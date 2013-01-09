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
	end
end