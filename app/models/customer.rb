class Customer < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :phone, :as => [:admin, :user]

	def self.find_or_create_by_email(email)
		customer =  Customer.where(email: email).first
		unless customer.present?
			customer = Customer.new
			customer.assign_attributes({email: email}, as: :user)
			customer.save!
		end
		
		customer
	end
end
