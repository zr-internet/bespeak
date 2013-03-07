ActiveAdmin.register_page "Dashboard" do

	menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

	content :title => proc{ I18n.t("active_admin.dashboard") } do
	 # Here is an example of a simple dashboard with columns and panels.
	 #
		columns do
			column do
				panel "Revenue (this month)" do
					ul do
						month, last_m = Time.zone.now.beginning_of_month - 2.months, Time.zone.now.beginning_of_month + 2.months
						begin
							revenue = revenue_per_month(month)
							li do
								span month.strftime('%B') + ":"
								span "Paid #{revenue[:paid]}"
								span "+ Owed #{revenue[:owed]}"
								span "= Total #{revenue[:paid] + revenue[:owed]}"
							end
						end while (month += 1.month) <= last_m
					end
				end
			end
			column do
				panel "Recent Bookings" do
					ul do
						Booking.order("created_at DESC").limit(5).map do |booking|
							li link_to([booking.course,booking.customer_email].join(' '), admin_booking_path(booking))
						end
					end
				end
			end
		end
	end # content
end
