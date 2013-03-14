class CourseType < ActiveRecord::Base
  attr_accessible 	:cost_cents, :description, :name, :site_id, :as => :admin
	monetize 					:cost_cents
	
	belongs_to				:site,			inverse_of: :course_types
	has_many					:courses
	
	def to_s
		name
	end
	alias_method :to_label, :to_s
end
