source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.5'
# Rails API modules rest here.
gem 'rails-api'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc
# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development
# Database - Postgres Adapter
gem 'pg'
# Pagination
gem "kaminari"
# State Machine
gem 'state_machine'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Show Progress bar while runinng a rake tasks which consumes more time
gem 'ruby-progressbar'
# Helps to print colored texts to console
gem "colorize"
gem "jquery-validation-rails"

group :development do

  #gem "handy-css-rails", "0.0.7"
  #gem "humdrum-rails", "0.1.2"
  gem "handy-css-rails", :path => "/Users/kvarma/Projects/VarmaLabs/OpenSource/handycss-rails"
  gem "humdrum-rails", :path => "/Users/kvarma/Projects/VarmaLabs/OpenSource/humdrum"

  # For Deployment
  gem 'capistrano'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv', github: "capistrano/rbenv"
  gem "capistrano-sidekiq"

  # Productivity & Performance Tools
  gem "brakeman", :require => false # vulnerability scanner
  gem "hirb"  # Print Better on Conosle
  gem "quiet_assets" # Stop displaying asset request on server console
  gem 'thin' # Better Web Server than Webrick
  gem "binding_of_caller"
end

group :development, :test do
  gem 'pry-rails' # Beautiful Console
end

group :test do
  # Factory
  gem "factory_girl_rails"

  # For rSpec
  gem 'rspec-rails' # Needed for rake stats to calculate test coverage
  #gem 'rspec-collection_matchers', '~> 1.0.0'
  #gem 'rspec-instafail'
  #gem "shoulda"
  # gem "rspec-sidekiq" #Needed to test sidekiq jobs

  # For Cucumber
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  #gem 'email_spec'
  #gem 'cucumber-websteps'
  #gem 'pickle'
  #gem 'capybara'
  #gem 'capybara-email'


  # Speedup Tests
  gem "spork"
  gem "parallel_tests"

  # For Code Climate - Test Code Coverage
  # https://codeclimate.com/repos/528da18dc7f3a335fa02e86d/coverage_setup
  gem 'codeclimate-test-reporter', require: nil
end
