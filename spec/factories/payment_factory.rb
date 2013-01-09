FactoryGirl.define do
  factory :payment do
    method				:cash
		amount				Money.new(1.0)
		token					{ SecureRandom.urlsafe_base64(9) }
		booking
  end
end