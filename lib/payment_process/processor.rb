require 'authorize_net'

module PaymentProcess
  module Processor
  	def process!(options)
  		self.token = nil

			case self.method
			when self.class.payment_methods[:cash]
				self.token = SecureRandom.urlsafe_base64(9)
			when self.class.payment_methods[:credit_card]
				if Rails.env.production? 
					gateway = :production
				else
					gateway = :sandbox
				end
  			transaction = AuthorizeNet::AIM::Transaction.new(ENV['AUTHORIZE_NET_LOGIN_ID'], ENV['AUTHORIZE_NET_TRANSACTION_KEY'],
  			  :gateway => gateway)
  			credit_card = AuthorizeNet::CreditCard.new(options[:credit_card_number], options[:credit_card_expiration_month].to_s+options[:credit_card_expiration_year].to_s, {:card_code => options[:ccv]})
  			response = transaction.purchase(self.amount.to_s, credit_card)

  			if response.success?
  			  logger.debug "Successfully made a purchase (authorization code: #{response.authorization_code})"
  				if Rails.env.production? 
						self.token = response.transaction_id
					else
						self.token = SecureRandom.urlsafe_base64(9)
					end
  			else
					logger.debug response.fields[:response_reason_text]
  			  self.errors.add(:token, response.fields[:response_reason_text])
  			end
			when self.class.payment_methods[:coupon]
				self.token = options[:coupon_code]
				self.amount = self.booking.course_cost
  		else
  			raise NotImplementedError
  		end
  	end
  end
end