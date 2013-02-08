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
  end
end