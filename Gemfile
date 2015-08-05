source 'https://rubygems.org'

ruby '2.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# heroku's 12factor gem
gem 'rails_12factor'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# gem is no longer supported but still useful
gem 'validates_timeliness', '3.0.14'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# puma because heroku likes it
gem 'puma'

# simple form because it's nice
gem 'simple_form', '~> 3.1'

gem 'nested_form', '0.3.2'

# materialize is nice as well
gem 'materialize-sass'

# will_paginate for pagination
gem 'will_paginate', '3.0.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# for running rake db:seed on heroku
gem 'factory_girl_rails', '4.5.0'
gem 'faker', '1.4.3'

# Gems used only in testing
group :test do
  gem 'shoulda', '3.5.0'
  gem 'shoulda-matchers', '2.8.0'
  gem 'mocha', require: false
  gem 'simplecov', '0.10.0'
  gem 'single_test', '0.6.0'
  gem 'minitest-reporters', '1.0.19'
  gem 'capybara'
  gem 'cucumber-rails', '1.4.2', require: false
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'launchy'
end

group :development do
  gem 'quiet_assets', '1.1.0'
  gem 'better_errors', '2.1.1'
  gem 'binding_of_caller', '0.7.2'
  gem 'wirble', '0.1.3'
  gem 'hirb', '0.7.3'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
