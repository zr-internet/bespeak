FactoryGirl.define do
  factory :course do
    course_type
		office
		start_at					Time.utc(2012,1,1,10)
		end_at						Time.utc(2012,1,1,12)
  end
end