class Payment < ActiveRecord::Base
  belongs_to :booking, :inverse_of => :payments
  attr_accessible :amount_cents, :token, :method, :booking_id, :as => [:admin, :customer]

	validates	:token, :presence => true, :uniqueness => true
	validates	:method, :presence => true
	validates	:booking, :presence => true
	validates	:amount_cents, :presence => true

	monetize	:amount_cents
	
	def self.payment_methods
	  { :cash => "cash", :credit_card => "credit_card" }
	end
end