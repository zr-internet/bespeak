require 'rubygems'
require 'spork'
require 'factory_girl_rails'
 
Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
	require 'debugger' unless ENV["CI"]

  RSpec.configure do |config|
    config.use_transactional_fixtures = false
	  config.treat_symbols_as_metadata_keys_with_true_values = true
		config.before(:suite) do
			ActiveRecord::Observer.disable_observers
		end
  end
  
end
 
Spork.each_run do
	# reload all the models
  Dir["#{Rails.root}/app/models/**/*.rb"].each do |model|
    load model
  end
	# reload all the helpers
  Dir["#{Rails.root}/app/helpers/**/*.rb"].each do |helper|
    load helper
  end
	# reload all the controllers
  Dir["#{Rails.root}/app/controllers/**/*.rb"].each do |controller|
    load controller
  end
	# reload all the mailers
  Dir["#{Rails.root}/app/mailers/**/*.rb"].each do |mailer|
    load mailer
  end
	# reload all the workers
  Dir["#{Rails.root}/app/workers/**/*.rb"].each do |worker|
    load worker
  end
	# reload all lib
  Dir["#{Rails.root}/lib/**/*.rb"].each do |lib|
    load lib
  end
	FactoryGirl.reload
	Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
end

