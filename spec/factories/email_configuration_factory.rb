# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email_configuration do
    name	"Mandrill Test Account"
		key		"this is a test mandrill key"
		confirmation_template		"test confirmation template"
  end
end
