module Forecasts
  class DarkSkyClient
    BASE_URL = 'https://api.darksky.net'.freeze

    # We only care about the daily forecast and alerts atm
    EXCLUDE  = %w[
      currently
      minutely
      hourly
      flags
    ].freeze

    def initialize
      @api_key = ENV.fetch('DARK_SKY_API_KEY')
    end

    def forecast(coords)
      url          = "#{BASE_URL}/forecast/#{@api_key}/#{coords * ','}"
      query_params = "?exclude=#{EXCLUDE * ','}"

      # TODO: Error handling for nil values... Error handling in Client
      get(url + query_params)['daily']['data']
    end

    private

    def get(url)
      with_error_handling do
        HTTParty.get(url)
      end
    end

    def with_error_handling
      # TODO: Handling for unexpected errors
      yield
    end
  end
end
