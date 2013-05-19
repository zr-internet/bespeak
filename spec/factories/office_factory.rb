FactoryGirl.define do
  factory :office do
		name				"test office"
		address			"office address"
		
		time_zone		"Pacific Time (US & Canada)"
		
		site
  end
end