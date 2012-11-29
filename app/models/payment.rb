class Payment < ActiveRecord::Base
  belongs_to :booking
  attr_accessible :amount_cents, :token, :method, :booking_id, :as => [:admin, :customer]

	validate	:token, :required => true, :uniqueness => true
	validate	:method, :required => true
	validate	:booking, :required => true
	validate	:amount_cents, :required => true

	monetize	:amount_cents
	
	def self.payment_methods
	  { :cash => "cash", :credit_card => "credit_card" }
	end
end