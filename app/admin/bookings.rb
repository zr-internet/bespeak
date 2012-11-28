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
			column "paid" do |b| humanized_money_with_symbol(b.paid) end
	    default_actions
	  end
end
