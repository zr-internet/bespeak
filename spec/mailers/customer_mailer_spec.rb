require "spec_helper"

describe CustomerMailer do
	describe '#booking_confirmation' do
		let(:customer_email) { "customer@example.com"}
		let(:booking) { mock_model(Booking, :customer_email => customer_email) }
		
		it "should exist" do
			CustomerMailer.should respond_to :booking_confirmation
		end
		let(:mail) { CustomerMailer.booking_confirmation(booking) }
	
		it 'renders the subject' do
			mail.subject.should =~ /MA Gun Safety Class Registration/
		end

		it 'create an email for the customer' do
			mail.to.should include customer_email
		end
	end

end
