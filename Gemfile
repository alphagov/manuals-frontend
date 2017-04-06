source 'https://rubygems.org'

gem 'rails', '4.2.7.1'
gem 'slimmer', '~> 10.1.3'

gem 'govuk_frontend_toolkit', '1.2.0'
gem 'sass-rails', '~> 5.0.6'
gem 'uglifier', '>= 1.3.0'

gem 'unicorn', '4.8.2'

gem 'plek', '1.11.0'
gem 'gds-api-adapters', '~> 41.0'

gem 'airbrake', '4.0.0'
gem 'logstasher', '0.6.2'

gem 'govuk_navigation_helpers', '~> 5.1'
gem 'govuk_ab_testing', '~> 2.1'
gem 'statsd-ruby', '1.3.0', require: 'statsd'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'govuk-lint'
  gem 'jasmine-rails'
  gem "rspec-rails", "~> 3.0"
end

group :test do
  gem "webmock", "~> 2.1.0"
  gem "poltergeist", "1.5.0"
  gem "launchy"
  gem "govuk-content-schema-test-helpers", "1.3.0"
end
