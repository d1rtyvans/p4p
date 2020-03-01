source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'rails',    '~> 6.0.2', '>= 6.0.2.1'
gem 'pg',       '>= 0.18', '< 2.0'
gem 'puma',     '~> 4.1'
gem 'redis'

# Prob don't need this but let's keep it for now
gem 'bootsnap', '>= 1.4.2', require: false

# Will likely need this in the future. Uncomment when you do
# gem 'rack-cors'

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rb-readline'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # The minute spring acts up it's getting removed
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
