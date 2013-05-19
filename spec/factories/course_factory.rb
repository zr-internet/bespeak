FactoryGirl.define do
  factory :course do
    course_type
		office
		
		start_at					Time.utc(2012,1,1,10)
		end_at						Time.utc(2012,1,1,12)
		
		factory :open_course do
			max_occupancy		20
			start_at				{ Time.now + 1.day }
			end_at					{ Time.now + 1.day + 1.hour }
		end

		after(:build) do |course, evaluator|
			course.office.site = if course.site.present?
				course.site
			else
				course.office.site
			end
			course.site = course.course_type.site = course.office.site
			
		end
  end
end