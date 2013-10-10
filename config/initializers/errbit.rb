Airbrake.configure do |config|
  config.api_key = '34e30b8f4c4e1e5da80fce59497883d7'
  config.host    = 'crowdvert-errbit.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
end