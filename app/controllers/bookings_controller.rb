class BookingsController < InheritedResources::Base
	respond_to :json, :only => :create
	
	def create
		params_comb = [:course_id, :attendees, :email, :payment_method, :payment_details, :coupons]
		customer = Customer.find_or_create_by_email(params[:email])
		course = Course.find(params[:course_id])
		
		@booking = course.bookings.new
		@booking.customer, @booking.attendees = customer, params[:attendees]
		payment = @booking.payments.build
		payment.method = params[:payment_method]

		payment.amount = @booking.owed unless payment.cash? 
		
		payment.extend PaymentProcess::Processor
		payment.process!(params[:payment_details])
		
		create!
	end	
end
