ActiveAdmin.register Customer do
	belongs_to		:site, :finder => :find_by_token, :param => :site_id
	navigation_menu	:site
	
	breadcrumb do
		site = Site.find_by_token(params[:site_id])
		breadcrumb = [
			link_to('Admin', admin_root_path),
			link_to(site.name, admin_site_path(site)),
			link_to(Customer.name.tableize.humanize, admin_site_customers_path(site)) 
		]
		breadcrumb << link_to(resource.to_label, admin_site_customer_path(site,resource)) if params[:id].present? && controller.action_name != "show"
		breadcrumb
	end
	
	config.sort_order = "created_at_asc"
	index do
		site = Site.find_by_token(params[:site_id])
		
		column :name
		column :email
		column :phone
		column "bookings", :sortable => :true do |customer|
			link_to customer.bookings.count, :controller => "bookings", :site_id => params[:site_id], :action => "index", 'q[customer_id_eq]' => "#{customer.id}".html_safe
		end
		column "owed" do |customer|
			total_cents = customer.bookings.inject(0) { |total, b| total += b.owed_cents }
			humanized_money_with_symbol(Money.new(total_cents))
		end
		column "paid" do |customer|
			total_cents = customer.bookings.inject(0) { |total, b| total += b.paid_cents }
			humanized_money_with_symbol(Money.new(total_cents))
		end
		
		default_actions
	end
	
  form do |f|
		f.inputs name: "Customer" do
			f.input :name
			f.input :email
			f.input :phone
		end
		f.buttons
	end
end
