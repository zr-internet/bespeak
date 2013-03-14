ActiveAdmin.register Payment do
	belongs_to		:site, :finder => :find_by_token, :param => :site_id
	navigation_menu	:site
	breadcrumb do
		site = Site.find_by_token(params[:site_id])
		breadcrumb = [
			link_to('Admin', admin_root_path),
			link_to(site.name, admin_site_path(site)),
			link_to(Payment.name.tableize.humanize, admin_site_payments_path(site)) 
		]
		breadcrumb << link_to(resource.to_label, admin_site_payment_path(site,resource)) if params[:id].present? && controller.action_name != "show"
		breadcrumb
	end
	
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
		site = Site.find_by_token(params[:site_id])
    column :id
		column "booking" do |payment|
			link_to payment.booking.course.to_s, admin_site_booking_path(site, payment.booking)			
		end
		column "customer" do |payment|
			link_to payment.booking.customer.email, admin_site_customer_path(site, payment.booking.customer)
		end
		column :method
		column "amount" do |p| humanized_money_with_symbol(p.amount) end
		column :token
		column :created_at

    default_actions
  end
end
