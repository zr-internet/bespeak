class Customer < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :phone, :site_id, :as => [:admin, :user]

	has_many			:bookings, :inverse_of => :customer
	has_many			:payments, :through => :bookings
	belongs_to		:site, :inverse_of => :customers

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
	alias_method :to_label, :to_s

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
