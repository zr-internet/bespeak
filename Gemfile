require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']

source 'http://rubygems.org'

ruby '1.9.3'
gem 'rails', '~> 3.2'
gem 'rake', '~> 10.0'

gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
	gem "therubyracer"
  gem 'uglifier', '>= 1.0'
  gem 'coffee-rails'
  gem "asset_sync"
	gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
  gem 'sass-rails', "~> 3.2"
end

gem 'addressable'
gem "haml", '~>4'
gem 'jquery-rails'
gem 'twitter-bootstrap-rails', '~>2'
gem "fog"

gem 'activeadmin'
gem 'omniauth'
gem "authorize-net", "~> 1.5.2"
gem "mandrill-api", "~> 1.0"


gem 'responders'

gem 'money-rails'
gem 'chronic'
gem 'geocoder'
gem 'rabl'
gem "high_voltage"
gem 'draper', '~> 1'

gem 'airbrake_user_attributes'

gem "dalli"
gem 'le'

gem 'rack-jsonp-middleware', :require => 'rack/jsonp'

gem 'rack-cors', :require => 'rack/cors'
gem 'rack-cache'

group :development do
  gem "rails3-generators"

  gem "haml-rails"
	gem 'rb-fsevent', '~> 0.9'
  gem "guard"
  gem "guard-bundler"
  gem "guard-rspec"
  gem "guard-spork"
  gem "rails-footnotes"
  gem 'quiet_assets'
end

group :development, :test do
  gem 'spork', '~> 0.9'
  gem "factory_girl_rails", :require => false
  gem "rspec-rails"
  gem "foreman"
  gem "timecop"
  gem "growl"
  unless ENV["CI"]
    gem 'debugger'
  end
	gem 'thin'
end

group :test do
  gem "capybara"
  gem "database_cleaner"
	gem "no_peeping_toms", "~> 2"
  gem "pickle"
  gem "bourne"
  gem "timecop"
  gem "shoulda-matchers"
	gem "json_spec"
  gem "email_spec"
  gem "poltergeist"
  gem "vcr"
	gem "excon"
end

group :production do
	gem 'unicorn'
	gem 'newrelic_rpm'
  gem 'memcachier'
end