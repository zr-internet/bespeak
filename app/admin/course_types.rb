ActiveAdmin.register CourseType do
	belongs_to		:site, :finder => :find_by_token, :param => :site_id
	navigation_menu	:site	
	
	breadcrumb do
		site = Site.find_by_token(params[:site_id])
		breadcrumb = [
			link_to('Admin', admin_root_path),
			link_to(site.name, admin_site_path(site)),
			link_to(CourseType.name.tableize.humanize, admin_site_course_types_path(site)) 
		]
		breadcrumb << link_to(resource.to_label, admin_site_course_type_path(site,resource)) if params[:id].present? && controller.action_name != "show"
		breadcrumb
	end
	
end
