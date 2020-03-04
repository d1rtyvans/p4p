require 'sidekiq/web'

Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :resorts, only: %i[create] do
        resources :forecasts, only: %i[index]
      end
    end
  end


  # Web UI for viewing and managing Sidekiq workers
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    # Protect against timing attacks:
    # - See https://codahale.com/a-lesson-in-timing-attacks/
    # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
    # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
    sidekiq_user = ENV.fetch('SIDEKIQ_USER')
    sidekiq_pw   = ENV.fetch('SIDEKIQ_PW')
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username),
                                                ::Digest::SHA256.hexdigest(sidekiq_user)) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password),
                                                  ::Digest::SHA256.hexdigest(sidekiq_pw))
  end

  mount Sidekiq::Web, at: '/asdf'
end
