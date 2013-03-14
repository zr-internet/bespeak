class PaymentProcessor < ActiveRecord::Base
  attr_accessible		:id, :login, :key, :name, as: :admin

	belongs_to				:site, inverse_of: :payment_processor
	validates					:site, presence: true
end
