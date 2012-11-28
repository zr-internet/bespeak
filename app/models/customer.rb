class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :remember_me, :name, :phone, :password, :password_confirmation, :as => [:admin, :user]

	def self.find_or_create_by_email(email)
		customer =  Customer.where(email: email).first
		unless customer.present?
			customer = Customer.new
			customer.assign_attributes({email: email}, as: :user)
			customer.save!(validate: false)
		end
		
		customer
	end
end
