class Payment < ActiveRecord::Base
  attr_accessible :amount_cents, :token, :method, :booking_id, :as => [:admin, :customer]

	validates	:method, :presence => true
	validates	:booking, :presence => true
	with_options :if => :credit_card? do |payment|
		validates	:token, :presence => true
		validates :token, :uniqueness => true, :if => :token?
	end
	validates	:amount_cents, :presence => true

  belongs_to 	:booking, :inverse_of => :payments
	has_one			:site, through: :course, :inverse_of => :payments

	monetize	:amount_cents
	
	def self.payment_methods
	  { :cash => "cash", :credit_card => "credit_card", :coupon => "coupon" }
	end
	
	def credit_card?
		method == self.class.payment_methods[:credit_card]
	end
	
	def cash?
		method == self.class.payment_methods[:cash]
	end
	
	def coupon?
		method == self.class.payment_methods[:coupon]
	end
	
	def to_label
		[ booking.customer_email, method, amount, token].join('-')
	end
	
	def self.cashs
		where(method: "cash")
	end
	
	def self.credit_cards
		where(method: "credit_card")
	end
	
	def self.coupons
		where(method: "coupon")
	end
end