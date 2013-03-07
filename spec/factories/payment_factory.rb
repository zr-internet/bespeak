FactoryGirl.define do
  factory :payment do
    method				"cash"
		amount				Money.new(0)
		token					{ SecureRandom.urlsafe_base64(9) }
		booking
		
		trait :cash do
			method				"cash"
		end
		
		trait :coupon do
			method			"coupon"
		end
		
		trait :credit_card do
			method			"credit_card"
		end
		
		factory :cash_payment,					traits: [:cash]
		factory :coupon_payment,				traits: [:coupon]
		factory :credit_card_payment,		traits: [:credit_card]
  end
end