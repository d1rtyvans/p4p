source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Self explanatory gems
gem 'rails',    '~> 6.0.2', '>= 6.0.2.1'
gem 'pg',       '>= 0.18', '< 2.0'
gem 'puma',     '~> 4.1'
gem 'redis'
gem 'sidekiq'

# Prob don't need this but let's keep it for now
gem 'bootsnap', '>= 1.4.2', require: false

# Abort requests that are taking too long
gem 'rack-timeout'

# Faster and more pleasant API than RestClient
gem 'httparty'

# Will likely need this in the future. Uncomment when you do
# gem 'rack-cors'

# pry > (irb || byebug)
gem 'pry-rails'
gem 'rb-readline'

group :development do
  # Easily use a single script to start up development servers
  gem 'foreman'

  # The minute spring acts up it's getting removed
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'dotenv-rails'

  # Easily set up test data
  gem 'factory_bot_rails'
  gem 'faker'

  # Record and replay outside requests in tests
  gem 'vcr'
  gem 'webmock'
end

group :test do
  # Test associations, validations with 1 liners
  gem 'shoulda-matchers'
end
