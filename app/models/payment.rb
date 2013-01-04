class Payment < ActiveRecord::Base
  belongs_to :booking, :inverse_of => :payments
  attr_accessible :amount_cents, :token, :method, :booking_id, :as => [:admin, :customer]


	validates	:method, :presence => true
	validates	:booking, :presence => true
	
	with_options :if => :credit_card? do |payment|
		validates	:token, :presence => true
		validates :token, :uniqueness => true, :if => :token?
	end

	validates	:amount_cents, :presence => true

	monetize	:amount_cents
	
	def self.payment_methods
	  { :cash => "cash", :credit_card => "credit_card" }
	end
	
	def credit_card?
		method == self.class.payment_methods[:credit_card]
	end
	
	def cash?
		method == self.class.payment_methods[:cash]
	end
end