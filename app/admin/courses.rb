ActiveAdmin.register Course do
  index do
		column "start", :sortable => :start do |course| course.start.strftime("%F - %l:%M %P") end
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
end
