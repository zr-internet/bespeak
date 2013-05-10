class EmailConfiguration < ActiveRecord::Base
  attr_accessible :name, :key, :confirmation_template, :reminder_template, :as => :admin
	belongs_to						:site, inverse_of: :email_configuration
end
