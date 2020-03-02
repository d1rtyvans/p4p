module Forecasts
  class WeatherbitCollector
    attr_reader :client

    def initialize(options)
      @resort_id = options.fetch(:resort_id)
      @coords    = options.fetch(:coords)
      @client    = WeatherbitClient.new
    end

    def do!
      with_error_handling do
        forecasts = format_forecast_data(get_forecasts)
        create_forecasts!(forecasts)
      end
    end

    private

    def create_forecasts!(forecasts)
      # TODO: Error handling
      # TODO: Make idempotent
      WeatherbitForecast.transaction do
        forecasts.each do |forecast_data|
          WeatherbitForecast.create!(forecast_data)
        end
      end
    end

    def get_forecasts
      client.forecast(@coords)
    end

    def format_forecast_data(forecasts)
      timestamp = Time.current
      forecasts.map do |forecast_data|
        {
          date:                unix_time_to_date(forecast_data['ts']),
          resort_id:           @resort_id,
          last_update:         timestamp,
          last_update_attempt: timestamp,
          status:              'synced',
          payload: {
            hi_temp:     forecast_data['max_temp'],
            lo_temp:     forecast_data['min_temp'],
            precip_prob: forecast_data['pop'],
            snow_depth:  forecast_data['snow_depth'],
            snowfall:    forecast_data['snow'],
            wind_speed:  forecast_data['wind_spd'],
            visibility:  km_to_mile(forecast_data['vis']), # TODO: May already by miles
          }
        }
      end
    end

    def with_error_handling
      # TODO: Error handling
      yield
    end

    def km_to_mile(kms)
      # Caps out at 10 mi
      return 10 if kms == 15

      # This is close enough for what we're using it for. Don't need to store the
      # extra decimals, if a time comes when we need that exact data this can
      # always be updated
      kms * 0.62
  end

    def unix_time_to_date(unix_time)
      Time.at(unix_time).to_date
    end
  end
end
