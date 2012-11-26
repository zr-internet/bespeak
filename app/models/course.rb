class Course < ActiveRecord::Base
  attr_accessible :course_type_id, :end, :max_occupancy, :office_id, :start, :as => :admin

	belongs_to :office
	belongs_to :course_type
	
	def to_s
		[course_type.name, office.name, start.strftime("%F - %l:%M %P")].join(", ")
	end
end
