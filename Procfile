# Used to start up rails server in production
web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -e production -t 25 -C config/sidekiq.yml
