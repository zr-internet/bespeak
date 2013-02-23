ActiveAdmin.register Payment do
	form do |f|
		f.inputs name: "Payment" do
			f.input		:method,  :as => :radio, :collection => Payment.payment_methods
			f.input		:booking
			f.input		:amount_cents
			f.input		:token
		end
		f.buttons
	end
	
	index do
    column :id
		column "booking" do |payment|
			link_to payment.booking.course.to_s, admin_booking_path(payment.booking)			
		end
		column "customer" do |payment|
			link_to payment.booking.customer.email, admin_customer_path(payment.booking.customer)
		end
		column :method
		column "amount" do |p| humanized_money_with_symbol(p.amount) end
		column :token
		column :created_at

    default_actions
  end
end
