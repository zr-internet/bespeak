ActiveAdmin.register Course do
	index do
		column "start_at", :sortable => :start_at do |course|	 course.start_at.in_time_zone(course.office.time_zone).strftime("%B %d, %Y %H:%M (%Z)") end
		column :name
		column "office", :sortable => :office do |course| 
			link_to course.office.name, admin_office_path(course.office) 
		end
		column "attendees", :sortable => false do |course|
			link_to course.bookings.sum(:attendees), :controller => "bookings", :action => "index", 'q[course_id_eq]' => "#{course.id}".html_safe
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
		f.inputs "Course Details" do			 
			f.input :course_type									
			f.input :office						 
			f.input :start_at, :as => :datetime_picker, :placeholder => "YYYY-MM-DD HH:MM", :size => 22, :label => "Start (in office local time)"
			f.input :end_at, :as => :datetime_picker, :placeholder => "YYYY-MM-DD HH:MM", :size => 22, :label => "End (in office local time)"
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
	end
end
