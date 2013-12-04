require 'plain_text_params_filter'
require "addressable/uri"


class BookingsController < InheritedResources::Base
	respond_to :json, :only => :create
	before_filter PlainTextParamsFilter, only: :create
	
	def create
		params_comb = [:course_id, :attendees, :email, :payment_method, :payment_details, :coupons]
		
		course = Course.find(params[:course_id])
		site = course.site
		customer = site.customers.where(email: params[:email]).first_or_create({}, as: :user)
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
			success.json do
				confirmation_url = Addressable::URI.parse(@booking.site.confirmation_url)
				confirmation_url.query_values = {
					tid: @booking.id, total: @booking.paid.to_s, course: @booking.course_name, price: @booking.course_cost.to_s, quantity: @booking.attendees, office: @booking.office_name, time: @booking.course.decorate.start_date_time
				}.reverse_merge(confirmation_url.query_values || {})
				render json: { confirmation_url: confirmation_url.to_s }
			end
		end
	end	
end
