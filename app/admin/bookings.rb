ActiveAdmin.register Booking do
	belongs_to		:site, :finder => :find_by_token, :param => :site_id
	navigation_menu	:site
	
	breadcrumb do
		site = Site.find_by_token(params[:site_id])
		breadcrumb = [
			link_to('Admin', admin_root_path),
			link_to(site.name, admin_site_path(site)),
			link_to(Booking.name.tableize.humanize, admin_site_bookings_path(site)) 
		]
		breadcrumb << link_to(resource.to_label, admin_site_booking_path(site,resource)) if params[:id].present? && controller.action_name != "show"
		breadcrumb
	end
	
	filter :customer_email, :as => :string
	filter :course_course_type_name, :as => :select, :collection => CourseType.all.map(&:name), :label => "Course Type"
	filter :course_office_name, :as => :select, :collection => Office.all.map(&:name), :label => "Office"
	filter :course_start_at, :as => :date_range, :label => "Course Date"
	filter :created_at, :label => "Booking Date"
	
  index do
		site = Site.find_by_token(params[:site_id])
		
    column :id
		column "course" do |booking|
			link_to booking.course.to_s, admin_site_course_path(site, booking.course)
		end
		column "customer" do |booking|
			link_to booking.customer.email, admin_site_customer_path(site, booking.customer)
		end
		column :attendees
		column "owed" do |b| humanized_money_with_symbol(b.owed) end
		column "paid" do |b| link_to humanized_money_with_symbol(b.paid), :controller => "payments", :site_id => params[:site_id], :action => "index", 'q[booking_id_eq]' => "#{b.id}".html_safe end
    default_actions
  end

	csv do
		column :id
		column "course" do |booking|
			booking.course.to_s
		end
		column "customer" do |booking|
			booking.customer.email
		end
		column :attendees
		column "owed" do |b| humanized_money_with_symbol(b.owed) end
		column "paid" do |b| humanized_money_with_symbol(b.paid) end
		column "methods" do |b| 
			methods = []
			b.payments.each do |p|
				methods << p.method
			end
			methods.join(' & ')
		end
		column "tokens" do |b|
			tokens = []
			b.payments.each do |p|
				tokens << p.token
			end
			tokens.join(' & ')
		end
	end
	
	show do |booking|
		attributes_table do
			row :course
			row :customer do booking.customer.email end
			row :attendees
			row :owed do humanized_money_with_symbol(booking.owed) end
			row :paid do link_to humanized_money_with_symbol(booking.paid), :controller => "payments", :site_id => params[:site_id], :action => "index", 'q[booking_id_eq]' => "#{booking.id}".html_safe end
			row :created_at
			row :updated_at
		end
		active_admin_comments
	end
end
