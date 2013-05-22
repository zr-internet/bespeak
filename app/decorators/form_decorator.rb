class FormDecorator < Draper::Decorator
	@@default_fields = {
		"formstack" => { 
			"progress_step_1" => "Select Date", 
			"progress_step_2" => "Select Course",
			"progress_step_3" => "Review & Submit",
			"step_1_title" => "1. Select a Class Date",
			"step_1_course_type_office_select_heading" => "Select License",
			"step_2_title" => "2. Select a Course and Payment Option",
			"step_3_title" => "3. Review and Confirm"
		}
	}.freeze
	
	def initialize(object, options = {})
		super(object, options)
		
		@fields ||= @@default_fields[object.template].merge(object.options)
	end
	
	def value_for(field)
		@fields[field]
	end
end