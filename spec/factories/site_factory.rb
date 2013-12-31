# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site do
    name								"Test Site"
		token								{ Site.generate_token }
		confirmation_url		"http://test.com/thanks"
  end

	trait :authorize_net do
		after(:build) do |site, evaluator|
			site.build_payment_processor(FactoryGirl.attributes_for(:credit_card_payment_processor), as: :admin)
		end
	end
	
	trait :test_email do
		email_configuration
	end
end
