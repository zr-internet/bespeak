# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :form do
    name "Pastry Courses"
    template "formstack"
    site

		trait :customized do
			options( { "progress_step_1" => "Select Course", "progress_step_2" => "Payment Method",
				"progress_step_3" => "Payment Details",
				"step_1_title" => "Pick Your Course and Time",
				"step_1_course_type_office_select_heading" => "Which Course Do You Want To Take?",
				"step_2_title" => "How Do You want to Pay?",
				"step_3_title" => "Enter Your Payment Details"
			})
		end
		
		factory :customized_form,					traits: [:customized]
  end
end
