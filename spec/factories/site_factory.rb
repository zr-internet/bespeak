# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site do
    name								"Test Site"
		token								{ Site.generate_token }
		confirmation_url		"http://test.com/thanks"
  end

	trait :authorize_net do
		payment_processor
	end
	
	trait :test_email do
		email_configuration
	end
end
