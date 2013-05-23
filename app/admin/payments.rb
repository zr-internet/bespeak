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
		site = Site.find_by_token(params[:site_id])
		f.inputs name: "Payment" do
			f.input		:method,  :as => :radio, :collection => Payment.payment_methods
			f.input		:booking, collection: site.bookings
			f.input		:amount_cents
			f.input		:token
		end
		f.actions
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

	controller do
		def build_new_resource
			p = Payment.new
			if params[:payment]
				p.update_attributes(params[:payment].slice(:booking_id, :method, :amount_cents, :token), as: :admin)
			end
			p
		end
		
		def scoped_collection
			end_of_association_chain.includes(booking: [:customer, course: [:office, :course_type]])
		end
		
		def create
			create! do |format|
				format.html do
					redirect_to admin_site_payment_path(resource.site, resource)
				end
			end
		end
	end
end
