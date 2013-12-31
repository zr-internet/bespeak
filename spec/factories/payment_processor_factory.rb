# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment_processor do
    name "Test Payment Processor"
		login "Test Login"
    key "Test API Key"
    site

    factory :credit_card_payment_processor do
			name "Authorize.NET"
			login "59cw2sKAWq2"
	    key "4Y7t5v7YpFh59CLL"
    end
  end
end
