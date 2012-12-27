require 'spec_helper'

describe BookingObserver do
	context "#after_create" do
		let(:customer_email) { "customer@example.com" }
		let(:booking) { stub_model(Booking, :customer_email => customer_email) }
		let(:mail) { double(:deliver => true) }

		it "should call CustomerMailer.booking_confirmation for booking" do
			CustomerMailer.should_receive(:booking_confirmation).with(booking).and_return(mail)
			BookingObserver.instance.after_create(booking)
		end
		
		it "should deliver an email" do
			CustomerMailer.stub(:booking_confirmation).with(booking).and_return(mail)
			mail.should_receive(:deliver)
			BookingObserver.instance.after_create(booking)
		end
	end
end
