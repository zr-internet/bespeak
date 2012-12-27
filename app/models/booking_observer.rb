class BookingObserver < ActiveRecord::Observer
	def after_create(booking)
		debugger
		mail = CustomerMailer.booking_confirmation(booking)
		mail.deliver
	end
end
