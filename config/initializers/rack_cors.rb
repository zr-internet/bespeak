Bespeak::Application.configure do
	config.middleware.use Rack::Cors do
		allow do
		  origins '*'
		  resource '/bookings.json', :headers => :any, :methods => :post
			resource '*.json', :headers => :any, :methods => :get
		end
	end
end