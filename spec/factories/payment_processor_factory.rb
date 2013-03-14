# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment_processor do
    name "Test Payment Processor"
		login "Test Login"
    key "Test API Key"
  end
end
