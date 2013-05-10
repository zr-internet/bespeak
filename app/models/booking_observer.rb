class BookingObserver < ActiveRecord::Observer
	def after_create(booking)
		booking.extend(Emailer::MandrillPlugin).send_confirmation
		
		# mail = AdminMailer.booking_confirmation(booking)
		# mail.deliver
	end
end
