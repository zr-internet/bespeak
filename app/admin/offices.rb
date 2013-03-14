require 'active_support'

ActiveAdmin.register Office do
	belongs_to		:site, :finder => :find_by_token, :param => :site_id
	navigation_menu	:site
	
	breadcrumb do
		site = Site.find_by_token(params[:site_id])
		breadcrumb = [
			link_to('Admin', admin_root_path),
			link_to(site.name, admin_site_path(site)),
			link_to(Office.name.tableize.humanize, admin_site_offices_path(site)) 
		]
		breadcrumb << link_to(resource.to_label, admin_site_office_path(site,resource)) if params[:id].present? && controller.action_name != "show"
		breadcrumb
	end
	
	form do |f|
		f.inputs name: "Office" do
			f.input :name
			f.input :phone
			f.input :address
			f.input :directions
			f.input :time_zone, :as => :select, :collection => ActiveSupport::TimeZone.us_zones
		end
		f.buttons
	end
end
