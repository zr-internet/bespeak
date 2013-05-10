class AdminMailer < ActionMailer::Base
  default from: "noreply@bespeakbooking.com"

	def booking_confirmation(booking)
		@booking = booking
		mail(:to => 'michaelzenga@hotmail.com', :subject => "#{@booking.site.name} #{@booking.office_name} #{@booking.course_name} #{@booking.course.start_at.in_time_zone @booking.course.office.time_zone} Registration" )
	end

end
