source 'https://rubygems.org'
ruby '2.4.1'

# Backend
gem 'rails', '5.1.4' # Latest stable
gem 'pg' # Use Postgresql as database
gem 'puma' # Use Puma as the app server
gem 'active_model_serializers' # ActiveModel::Serializer implementation and Rails hooks
gem 'ffaker' # A library for generating fake data such as names, addresses, and phone numbers.
gem 'fabrication' # Fabrication generates objects in Ruby. Fabricators are schematics for your objects, and can be created as needed anywhere in your app or specs.
gem 'sidekiq', '5.0.0.beta2' # background processing for Ruby
gem 'whenever', require: false # Cron jobs in Ruby
gem 'line-bot-api' # Line::Bot::API - SDK of the LINE Messaging API for Ruby
gem 'wit' # Ruby SDK for Wit.ai

# Assets
gem 'sass-rails' # SASS
gem 'uglifier'

group :development do
  gem 'better_errors' # Better error page for Rails and other Rack apps
  gem 'binding_of_caller' # Retrieve the binding of a method's caller in MRI 1.9.2+
  gem 'bullet' # help to kill N+1 queries and unused eager loading
  gem 'awesome_print' # Pretty print your Ruby objects with style -- in full color and with proper indentation
  gem 'guard-rubocop'
  gem 'roadie-rails' # Mailers
  gem 'rubycritic', require: false # A Ruby code quality reporter
  gem 'foreman' # Manage Procfile-based applications
end

group :development, :test do
  gem 'figaro' # Simple Rails app configuration

  gem 'rspec-rails' # Rails testing engine
  gem 'rails-controller-testing' # brings back assigns to your controller tests as well as assert_template to both controller and integration tests
  gem 'guard-rspec' # Auto-run specs
  gem 'shoulda-matchers', '3.1.2' # Tests common Rails functionalities
  gem 'capybara' # Integration testing
  gem 'poltergeist' # Headless browser
  gem 'selenium-webdriver' # Headless browser
  gem 'database_cleaner' # Use Database Cleaner

  gem 'pry-rails' # Rails `pry` initializer
  gem 'spring' # Spring speeds up development by keeping your application running in the background.
  gem 'spring-watcher-listen', '~> 2.0.0' # Makes Spring watch the filesystem for changes using Listen
  gem 'spring-commands-rspec' # This gem implements the rspec command for Spring.
  gem 'listen', '~> 3.0.5' # Listens to file modifications
  gem 'letter_opener' # Preview mail in the browser instead of sending.
  gem 'rspec-json_expectations' # Set of matchers and helpers to allow you test your APIs responses like a pro.
  gem 'brakeman', require: false # A static analysis security vulnerability scanner for Ruby on Rails applications
  gem 'rspec-retry' # RSpec::Retry adds a :retry option for intermittently failing rspec examples
  gem 'capybara-screenshot' # Will capture a screen shot for each failure in your test suite
end

group :test do
  gem 'simplecov', require: false # code coverage analysis tool for Ruby
  gem 'sinatra', '2.0.0.rc1' # Stripe Fake Sinatra with Rack 2.0 (compatible with Rails 5)
  gem 'fake_stripe' # A Stripe fake so that you can avoid hitting Stripe servers in tests
end

group :production do
  gem 'rails_12factor'         # Makes running your Rails app easier. Based on the ideas behind 12factor.net (Heroku)
  gem 'rack-timeout'           # Rack middleware which aborts requests that have been running for longer than a specified timeout.
  gem 'newrelic_rpm'           # New Relic provides you with deep information about the performance of your web application as it runs in production.
end
