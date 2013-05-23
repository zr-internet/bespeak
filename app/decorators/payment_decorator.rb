class PaymentDecorator < Draper::Decorator
  delegate_all

	def description
		descriptions = {cash: 'Pay-Later', credit_card: 'Pay-Now', coupon: 'Coupon' }.freeze
		descriptions[source.method]
	end
	
	def price_now
		prices = {cash: '$0', credit_card: "$0", coupon: '$0' }.freeze
		prices[source.method]
	end
end