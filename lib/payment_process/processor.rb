require 'authorize_net'

module PaymentProcess
  module Processor
		AccessDetails = Struct.new(:login, :key)
		
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
				processor_details = AccessDetails.new
				if self.booking.site.present?
					processor_details.login = self.booking.site.payment_processor.login
					processor_details.key = self.booking.site.payment_processor.key
				else
					processor_details.login = ENV['AUTHORIZE_NET_LOGIN_ID']
					processor_details.key = ENV['AUTHORIZE_NET_TRANSACTION_KEY']
				end
  			transaction = AuthorizeNet::AIM::Transaction.new(processor_details.login, processor_details.key,
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
  				reason = {code: response.fields[:response_reason_code] || "unknown", text: response.fields[:response_reason_text] || ""}
					logger.debug reason.to_s
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