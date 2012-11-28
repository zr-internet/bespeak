class BookingsController < InheritedResources::Base
	respond_to :json, :only => :create
	
	def create
		params_comb = [:course_id, :attendees, :email, :cost, :payment_method, :payment_details, :coupons]
		customer = Customer.find_or_create_by_email(params[:email])
		course = Course.first
		
		@booking = Booking.new
		@booking.customer, @booking.course, @booking.attendees = customer, course, params[:attendees]
		create!
	end	
end
