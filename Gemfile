# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'
gem 'rails', '~> 5.2.8', '>= 5.2.8.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
gem 'rails-ujs', '~> 0.1.0'
gem 'image_processing', '~> 1.12', '>= 1.12.2'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'faker'
  gem 'rubocop-rspec'
  gem 'rexml'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'simplecov'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rails-controller-testing'
  # gem 'chromedriver-helper'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'cloudinary'
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'devise-guests', '~> 0.5.0'
gem 'pundit'
gem 'stripe'
gem 'pg_search'
