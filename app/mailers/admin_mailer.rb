class AdminMailer < ActionMailer::Base
  default from: "noreply@bespeak.com"

	def booking_confirmation(booking)
		@booking = booking
		mail(:to => 'michaelzenga@hotmail.com', :subject => "[MGS] #{@booking.office_name} #{@booking.course_name} #{@booking.course_start_at} Registration" )
	end

end
