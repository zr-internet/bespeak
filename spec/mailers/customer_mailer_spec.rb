require "spec_helper"

describe CustomerMailer do
	describe '#booking_confirmation' do
		let(:booking) { FactoryGirl.build_stubbed(:booking) }
		
		it "should exist" do
			CustomerMailer.should respond_to :booking_confirmation
		end
		let(:mail) { CustomerMailer.booking_confirmation(booking) }
	
		it 'renders the subject' do
			mail.subject.should include booking.course_name
		end

		it 'create an email for the customer' do
			mail.to.should include booking.customer_email
		end
	end

end
