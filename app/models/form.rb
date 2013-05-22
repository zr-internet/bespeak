class Form < ActiveRecord::Base
  attr_accessible :name, :site_id, :template, :options, as: :admin
	serialize	:options, Hash
	
	belongs_to :site
	
	def template_fields
		@@fields ||= {"formstack" => ["progress_step_1","progress_step_2", "progress_step_3", "step_1_title", "step_1_course_type_office_select_heading", "step_2_title", "step_3_title"]}.freeze
		@@fields[template]
	end
	
	def self.default(template)
		Form.new({name:"default", template: template}, as: :admin)
	end
	
	def options
		read_attribute(:options) || {}
	end
end