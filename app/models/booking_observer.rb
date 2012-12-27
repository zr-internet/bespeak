class BookingObserver < ActiveRecord::Observer
	
	def after_create(booking)
		mail = CustomerMailer.booking_confirmation(booking)
		mail.deliver
	end
end
