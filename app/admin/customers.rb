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
	
  form do |f|
		f.inputs name: "Customer" do
			f.input :name
			f.input :email
			f.input :phone
			f.input :password               
      f.input :password_confirmation
		end
		f.buttons
	end
end
