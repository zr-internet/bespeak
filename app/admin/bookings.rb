ActiveAdmin.register Booking do
  index do
    column :id
		column "course" do |booking|
			link_to booking.course.to_s, admin_course_path(booking.course)
		end
		column "customer" do |booking|
			link_to booking.customer.email, admin_customer_path(booking.customer)
		end
		column :attendees
		column "owed" do |b| humanized_money_with_symbol(b.owed) end
		column "paid" do |b| link_to humanized_money_with_symbol(b.paid), :controller => "payments", :action => "index", 'q[booking_id_eq]' => "#{b.id}".html_safe end
    default_actions
  end
	
	show do |booking|
		attributes_table do
			row :course
			row :customer do booking.customer.email end
			row :attendees
			row :owed do humanized_money_with_symbol(booking.owed) end
			row :paid do link_to humanized_money_with_symbol(booking.paid), :controller => "payments", :action => "index", 'q[booking_id_eq]' => "#{booking.id}".html_safe end
			row :created_at
			row :updated_at
		end
		active_admin_comments
	end
	
end
