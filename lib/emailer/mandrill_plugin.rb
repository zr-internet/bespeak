require 'mandrill'

module Emailer
	module MandrillPlugin
		
		def send_confirmation()
			api = Mandrill::API.new(self.site_email_configuration.key, Rails.env.test?)
			api.messages.send_template(self.site_email_configuration.confirmation_template, [], build_message)
		end
		
		def send_reminder()
		end
		
		private
		def build_message
			message = {
				to: [ {:email=> self.customer_email} ],
				auto_text: true,
				inline_css: true,
				global_merge_vars: [ {name: "COURSE_NAME", content: self.course_name},
					{name: "OFFICE_NAME", content: self.office_name},
					{name: "COURSE_START", content: self.course_start_at.in_time_zone(self.office_time_zone).to_formatted_s(:long_ordinal)},
					{name: "OFFICE_ADDRESS", content: self.office_address},
					{name: "OFFICE_DIRECTIONS", content: ApplicationController.helpers.simple_format(self.office_directions)}
				]
			}
		end
	end
end