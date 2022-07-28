# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'rails', '~> 6.1.4', '>= 6.1.4.6'

gem 'aws-sdk-s3', '~> 1.113'
gem 'bcrypt', '~> 3.1', '>= 3.1.16'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'discard', '~> 1.2', '>= 1.2.1'
gem 'dotenv-rails', '~> 2.7', '>= 2.7.6'
gem 'jsonapi-serializer', '~> 2.2'
gem 'jwt', '~> 2.3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors', '~> 1.1', '>= 1.1.1'
gem 'rswag', '~> 2.5', '>= 2.5.1'

group :development, :test do
  gem 'factory_bot_rails', '~> 5.1', '>= 5.1.1'
  gem 'pry-byebug', '~> 3.9', platform: :mri
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 4.1'
end

group :development do
  gem 'annotate', '~> 3.0', '>= 3.0.3'
  gem 'brakeman', '~> 5.1', '>= 5.1.2'
  gem 'listen', '~> 3.3'
  gem 'rails_best_practices', '~> 1.20'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring', '~> 2.1'
  gem 'spring-watcher-listen', '~> 2.0.1'
end

group :test do
  gem 'faker', '~> 2.13'
  gem 'shoulda-matchers', '~> 4.1', '>= 4.1.2'
  gem 'simplecov', '~> 0.13.0', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
