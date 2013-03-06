class Customer < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :phone, :as => [:admin, :user]

	has_many			:bookings, :inverse_of => :customer
	has_many			:payments, :through => :bookings

	def owed
		self.bookings.reduce(Money.new(0)) { |total, booking| total += booking.owed }
	end

	def to_s
		return email if email.present?
		
		if id.present? then
			"customer_#{id}"
		else
			self.inspect
		end
	end
	def to_label
		self.to_s
	end

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
