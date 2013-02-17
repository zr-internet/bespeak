Bespeak::Application.configure do
	config.middleware.use Rack::Cors do
		allow do
		  origins '*'
		  resource '/bookings.json', :headers => :any, :methods => [:post, :options]
			resource '*.json', :headers => :any, :methods => :get
			resource '/courses/available.json', :headers => :any, :methods => :get
		end
	end
end