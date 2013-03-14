ActiveAdmin.register Site do
  form do |f|
		f.inputs "Site" do
			f.input :name	
		end
		f.inputs "Configuration" do
			f.object.payment_processor || f.object.build_payment_processor({name: 'Authorize.NET'}, as: :admin)
			f.semantic_fields_for :payment_processor do |pp|
				pp.inputs "Payment Processor" do
					pp.input	:name
					pp.input 	:login, label: 'Authorize.NET API Login ID'
					pp.input 	:key, label: 'Authorize.NET API Key'
				end
			end
		end

		f.actions
	end
	
	show do |site|
		attributes_table do
			row :id
			row :name
			row :token
			
			row :payment_processor do
				site.payment_processor.name
			end
			row :payment_processor_login do
				site.payment_processor.login
			end
			row :payment_processor_key do
				site.payment_processor.key
			end
			row :created_at
			row :updated_at
			
		end
		active_admin_comments
	end
	
	sidebar "Site Links", :only => :show do
		site = Site.find_by_token(params[:id])
		ul do
		  li link_to("Offices", admin_site_offices_path(site))
			li link_to("Course Types", admin_site_course_types_path(site))
      li link_to("Courses", admin_site_courses_path(site))
      li link_to("Bookings", admin_site_bookings_path(site))
	    li link_to("Customers", admin_site_customers_path(site))
			li link_to("Payments", admin_site_payments_path(site))
    end
  end

	controller do
		defaults :finder => :find_by_token
	end
end
