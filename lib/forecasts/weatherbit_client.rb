module Forecasts
  class WeatherbitClient
    BASE_URL = 'https://api.weatherbit.io'
    VERSION  = 'v2.0'
    DAYS     = 8

    def initialize
      @api_key = ENV.fetch('WEATHERBIT_API_KEY')
    end

    def forecast(coords)
      query_params = "?lat=#{coords[0]}&lon=#{coords[1]}&units=I&days=#{DAYS}&key=#{@api_key}"
      response = get('forecast/daily' + query_params)

      # TODO: Handling for nil values
      response['data']
    end

    private

    def get(url)
      # TODO: Error handling for messed up responses
      with_error_handling do
        HTTParty.get("#{BASE_URL}/#{VERSION}/#{url}")
      end
    end

    def with_error_handling
      # TODO: Handling for unexpected errors
      yield
    end
  end
end
