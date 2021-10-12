# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5"
gem "pg", "~> 0.21.0"
gem "geo_coord"
gem "graphql"
gem "graphql-batch"

# Use Puma as the app server
gem "puma", "~> 3.7"
gem "chronic"
# Use SCSS for stylesheets
gem "sass-rails", "~> 6.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "devise", "~> 4.7.1"
gem "dry-validation"
gem "gon", "~> 6.2"
gem "grape", "~> 1.5"
gem "grape-entity", "~> 0.7.0"
gem "grape-swagger", "~> 0.27.3"
gem "grape-swagger-entity", "~> 0.2.5"
gem "grape-swagger-ui", "~> 2.2"
gem "grape_on_rails_routes", git: "https://github.com/orbanbotond/grape_on_rails_routes", branch: "fix_latest_grape_1_0_2"
gem "jbuilder", "~> 2.5"
# gem "paperclip", "~> 6.0"
gem "pundit", "~> 1.1"
gem "slim", "~> 4.0"
gem "trailblazer"
gem "trailblazer-loader", "~> 0.1.2"
gem "webpacker"
gem "reform", "~> 2.2"
gem "reform-rails", "~> 0.1"

gem "granite"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "bullet", "~> 5.7"
  gem "awesome_print"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", "~> 3.29"
  gem "dotenv-rails", "~> 2.2"
  gem "factory_bot_rails", "~> 4.8"
  gem "ffaker", "~> 2.8"
  gem "guard", "~> 2.14"
  gem "guard-bundler", "~> 2.2", require: false
  gem "guard-rspec", "~> 4.7", require: false
  # gem "guard-rubocop", "~> 1.3", require: false
  gem "pry-byebug", "~> 3.5"
  gem "pry-rails"
  gem "pundit-matchers", "~> 1.4.1"
  gem "reek", "~> 5.4"
  gem "rspec-rails", "~> 3.6"
  gem "rubocop-rails_config"
  gem "selenium-webdriver", "~> 3.8"
  gem "shoulda-matchers", git: "https://github.com/thoughtbot/shoulda-matchers"
  gem "webmock"
  gem "pact"
  gem "httparty"
  gem "rspec-json_expectations"
end

group :test do
  gem "rspec_junit_formatter"
  gem "n_plus_one_control"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "graphiql-rails", group: :development
