source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.13'
gem 'haml'
gem 'jquery-rails'
gem 'bcrypt-ruby'

gem 'sqlite3', '~> 1.3.6'
gem 'mysql', '~> 2.9.1'
gem 'mysql2', '~> 0.3.13'
gem 'pg', '~> 0.17.0'


group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass', '2.3.1.0'
end

group :test do
  gem 'capybara'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'sqlite3'
end

group :production do
  # Change this to use another DB in production
  gem 'sqlite3'
end
