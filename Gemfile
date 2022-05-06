# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'faraday'
gem 'websocket-eventmachine-client'

group :dev do
  gem 'rake', '>= 13.0.0'
  gem 'yard'
end

group :test do
  gem 'rspec'
  gem 'rspec-parameterized'
  gem 'rubocop', require: false
  gem 'simplecov', require: false
  gem 'unparser', '~> 0.5.5' # support ruby 2.5
  gem 'webmock'
end
