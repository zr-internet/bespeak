Bespeak::Application.configure do
	config.middleware.use Rack::Cors do
		allow do
		  origins '*'
		  resource '/bookings.json', :headers => :any, :methods => :post
		end
	end
end