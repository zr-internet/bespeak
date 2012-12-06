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
  gem 'uglifier', '>= 1.0'
  gem 'coffee-rails'
  gem "asset_sync"
  gem 'sass-rails', "~> 3.2"
end

gem "haml"
gem 'jquery-rails'
gem 'thin'
gem "fog"

gem 'activeadmin'
gem 'omniauth'
gem "authorize-net", "~> 1.5.2"

gem 'money-rails'
gem 'chronic'
gem 'geocoder'
gem 'rabl'

gem 'rack-cors', :require => 'rack/cors'

group :development do
  gem "rails3-generators"

  gem "haml-rails"
  gem "guard"
  gem "guard-bundler"
  gem "guard-rspec"
  gem "guard-spork"
  gem "guard-cucumber"
  gem "rails-footnotes"
  gem 'quiet_assets'
end

group :development, :test do
  gem 'spork', '~> 0.9.2'
  gem "factory_girl_rails", :require => false
  gem "rspec-rails"
  gem "foreman"
  gem "timecop"
  gem "growl"
  unless ENV["CI"]
    gem 'debugger'
  end
end

group :test do
  gem "cucumber-rails"
  gem "capybara"
  gem "database_cleaner"
  gem "pickle"
  gem "bourne"
  gem "timecop"
  gem "shoulda-matchers"
  gem "email_spec"
  gem "poltergeist"
  gem "vcr"
end