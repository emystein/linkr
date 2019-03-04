source 'http://rubygems.org'

gem "rails"
gem 'puma', '~> 3.11'
gem 'jquery-rails'
gem 'sqlite3', '~> 1.3.6' # see: https://github.com/rails/rails/issues/35153
# gem 'pg'
gem 'redis'
gem 'redis-objects'
gem 'will_paginate'
gem 'acts-as-taggable-on'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'devise'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'bootsnap', '>= 1.1.0', require: false

group :development do
  gem 'pry'
  gem 'pry-doc'

  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem "rspec-rails"
  gem "shoulda-matchers", require: false
  gem "factory_bot_rails"
  gem 'database_cleaner'
  gem "launchy"
  # gem "rb-fsevent" if RUBY_PLATFORM =~ /darwin/
  gem "guard"
  gem "guard-rspec"
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "rails-controller-testing"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'


gem "activeresource", "~> 5.1"
