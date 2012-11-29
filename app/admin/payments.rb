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
end
