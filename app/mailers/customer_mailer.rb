class CustomerMailer < ActionMailer::Base
  default from: "info@massachusettsgunsafety.com"

	def booking_confirmation(booking)
		@booking = booking
		mail(:to => booking.customer_email, :subject => "MA Gun Safety Class Registration" )
	end
end
