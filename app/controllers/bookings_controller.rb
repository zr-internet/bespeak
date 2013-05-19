require 'plain_text_params_filter'

class BookingsController < InheritedResources::Base
	respond_to :json, :only => :create
	before_filter PlainTextParamsFilter, only: :create
	
	def create
		params_comb = [:course_id, :attendees, :email, :payment_method, :payment_details, :coupons]
		customer = Customer.find_or_create_by_email(params[:email])
		course = Course.find(params[:course_id])
		
		@booking = course.bookings.new
		@booking.customer, @booking.attendees = customer, params[:attendees]
		
		#process coupons prior to processing any payments
		coupon_payment = Money.new(0)
		if params[:coupon].present?
			payment = @booking.payments.build
			payment.method = "coupon"
			payment.extend PaymentProcess::Processor
			
			payment.process!(coupon_code: params[:coupon])
			coupon_payment = payment.amount
		end
		
		# if we still owe money after processing the coupon then process the additional payments
		if @booking.owed > Money.new(0)
			payment = @booking.payments.build
			payment.method = params[:payment_method]

			payment.amount = @booking.owed unless payment.cash?
			payment.extend PaymentProcess::Processor
			payment.process!(params[:payment_details])
		end
		create! do |success, failure|
			success.json { render json: { confirmation_url: @booking.site.confirmation_url } }
		end
	end	
end
