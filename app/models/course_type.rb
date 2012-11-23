class CourseType < ActiveRecord::Base
  attr_accessible 	:cost_cents, :description, :name,  :as => [:admin]

	monetize 					:cost_cents
end
