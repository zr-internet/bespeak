ActiveAdmin.register Site do
  form do |f|
		f.inputs "Site" do
			f.input :name
			f.input :confirmation_url
		end

		f.inputs do
			f.object.email_configuration || f.object.build_email_configuration({from: 'noreply@bespeakbooking.com'}, as: :admin)
			f.semantic_fields_for :email_configuration do |ec|
				ec.inputs "Email Configuration" do
					ec.input	:name
					ec.input	:key, label: 'Mandrill API Key'
					ec.input	:confirmation_template
					ec.input	:reminder_template
				end
			end
		end
		f.inputs do
			f.object.payment_processor || f.object.build_payment_processor({name: 'Authorize.NET'}, as: :admin)
			f.semantic_fields_for :payment_processor do |pp|
				pp.inputs "Payment Processor" do
					pp.input	:name
					pp.input 	:login, label: 'Authorize.NET API Login ID'
					pp.input 	:key, label: 'Authorize.NET API Key'
				end
			end
		end
		f.inputs do
			f.object.form || f.object.build_form({name: 'Form customization'}, as: :admin)
			f.semantic_fields_for :form do |site_form|
				site_form.inputs "Form Customization" do
					site_form.input	:name
					site_form.input	:template, collection: ["formstack"]
				end
				site_form.inputs "Content" do
					site_form.semantic_fields_for :options do |opts|
						opts.inputs do
							opts.input "progress_step_1", required: false, input_html: { value: site_form.object.options["progress_step_1"]}
							opts.input "progress_step_2", required: false, input_html: { value: site_form.object.options["progress_step_2"]}
							opts.input "progress_step_3", required: false, input_html: { value: site_form.object.options["progress_step_3"]}
							opts.input "step_1_title", required: false, input_html: { value: site_form.object.options["step_1_title"]}
							opts.input "step_1_course_type_office_select_heading", required: false, input_html: { value: site_form.object.options["step_1_course_type_office_select_heading"]}
							opts.input "step_2_title", required: false, input_html: { value: site_form.object.options["step_2_title"]}
							opts.input "step_3_title", required: false, input_html: { value: site_form.object.options["step_3_title"]}	
						end
					end
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
			
			row :confirmation_url
			
			row :email_configuration_name do
				site.email_configuration.name
			end
			row :email_configuration_key do
				site.email_configuration.key
			end
			row :email_configuration_confirmation_template do
				site.email_configuration.confirmation_template
			end
			row :email_configuration_reminder_template do
				site.email_configuration.reminder_template
			end
			
			
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
