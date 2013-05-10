require 'spec_helper'

describe BookingObserver, :vcr do
	context "#after_create" do
		let(:customer_email) { "customer@example.com" }
		let(:booking) { FactoryGirl.build_stubbed(Booking, customer: FactoryGirl.build_stubbed(Customer, email: customer_email)) }
		let(:mail) { double(:deliver => true) }

	  it 'should receive after_create on Booking creation' do
	    BookingObserver.any_instance.should_receive(:after_create).once
	    ActiveRecord::Observer.with_observers(:BookingObserver) do
	      FactoryGirl.create(:booking)
	    end
	  end

		context "confirmation emails" do
			let(:emailer) do 
				FactoryGirl.build(:emailer_details).extend Emailer::MandrillPlugin
			end
			
			it "should extend booking with Emailer::Mandrill" do
				booking.should_receive(:extend).with(Emailer::MandrillPlugin).and_return(emailer)
				BookingObserver.instance.after_create(booking)
			end
			
			it "should call emailer.send_confirmation" do
				booking.should_receive(:extend).with(Emailer::MandrillPlugin).and_return(emailer)
				emailer.should_receive(:send_confirmation)
				BookingObserver.instance.after_create(booking)
			end
		end
	end
end
