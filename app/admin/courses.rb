ActiveAdmin.register Course do
	belongs_to		:site, :finder => :find_by_token, :param => :site_id
	navigation_menu	:site
	
	breadcrumb do
		site = Site.find_by_token(params[:site_id])
		breadcrumb = [
			link_to('Admin', admin_root_path),
			link_to(site.name, admin_site_path(site)),
			link_to(Course.name.tableize.humanize, admin_site_courses_path(site)) 
		]
		breadcrumb << link_to(resource.to_label, admin_site_course_path(site,resource)) if params[:id].present? && controller.action_name != "show"
		breadcrumb
	end
	
	config.sort_order = "start_at_asc"
	index do
		site = Site.find_by_token(params[:site_id])
		
		column "start_at", :sortable => :start_at do |course|	 course.start_at.in_time_zone(course.office.time_zone).strftime("%B %d, %Y %H:%M (%Z)") end
		column :name
		column "office", :sortable => :office do |course| 
			link_to course.office.name, admin_site_office_path(site, course.office) 
		end
		column "attendees", :sortable => false do |course|
			link_to course.bookings.sum(:attendees), :controller => "bookings", :site_id => params[:site_id], :action => "index", 'q[course_id_eq]' => "#{course.id}".html_safe
		end
		column :max_occupancy
		
		default_actions
	end
	
	show do |course|
		attributes_table do
			row :course_type
			row :office
			row :start_at do
				course.start_at.in_time_zone(course.office.time_zone).strftime("%B %d, %Y %H:%M (%Z)")
			end
			row :end_at do
				course.end_at.in_time_zone(course.office.time_zone).strftime("%B %d, %Y %H:%M (%Z)")
			end
			row :max_occupancy
		end
		active_admin_comments
	end
	
	form do |f|
		site = Site.find_by_token(params[:site_id])
		f.inputs "Course Details" do			 
			f.input :course_type, collection: site.course_types
			f.input :office, collection: site.offices
			f.input :start_at, :as => :string, :placeholder => "YYYY-MM-DD HH:MM", :size => 22, :label => "Start (in office local time)"
			f.input :end_at, :as => :string, :placeholder => "YYYY-MM-DD HH:MM", :size => 22, :label => "End (in office local time)"
			f.input :max_occupancy
		end																
		f.buttons													
	end
	
	controller do
		def create
			timezone = Office.find(params[:course][:office_id]).time_zone
			params[:course][:start_at] = timezone.parse(params[:course][:start_at])
			params[:course][:end_at] = timezone.parse(params[:course][:end_at])
			super
		end
		
		def scoped_collection
			end_of_association_chain.includes(:bookings)
		end
	end
end
