require 'spec_helper'

describe Payment do
	describe ".payment_methods" do
		context do 
			subject { Payment }
			it { should respond_to :payment_methods }
		end
		context do 
			subject { Payment.payment_methods }
			it { should respond_to :each }
		end
	end

	Payment.payment_methods.each do |payment_method, string|
		describe "##{payment_method}?" do
			it { should respond_to "#{payment_method}?".to_sym }
		end
		describe ".#{payment_method}s" do
			subject { Payment }
			it { should respond_to "#{payment_method}s".to_sym }
		end
	end
	
	it { should respond_to :method }
	it { should respond_to :amount }
	it { should respond_to :token }
	
	it { should belong_to :booking }
	it { should respond_to :site }
	
	describe "#to_label" do
		let(:payment) { FactoryGirl.build_stubbed(:payment) }
		it { should respond_to :to_label }
		it "should return customer_email-method-amount-token" do
			payment.to_label.should == [ 
				payment.booking.customer_email, 
				payment.method, 
				payment.amount, 
				payment.token].join('-')
		end
	end
end
