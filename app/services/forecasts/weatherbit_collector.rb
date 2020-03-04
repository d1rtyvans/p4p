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
        forecasts = format_data(get_forecasts)
        upsert_forecasts!(forecasts)
      end
    end

    private

    def upsert_forecasts!(forecasts)
      # TODO: Error handling
      # TODO: Make idempotent
      WeatherbitForecast.upsert_all(forecasts,
                                    unique_by: [:resort_id, :date, :type])
    end

    def get_forecasts
      client.forecast(@coords)
    end

    def format_data(forecasts)
      timestamp = Time.current
      forecasts.map do |forecast_data|
        {
          type:                'WeatherbitForecast',
          date:                unix_time_to_date(forecast_data['ts']),
          resort_id:           @resort_id,
          created_at:          timestamp,
          updated_at:          timestamp,
          weather_data: {
            hi_temp:     forecast_data['max_temp'],
            lo_temp:     forecast_data['min_temp'],
            precip_prob: forecast_data['pop'],
            snow_depth:  forecast_data['snow_depth'],
            snowfall:    forecast_data['snow'],
            wind_speed:  forecast_data['wind_spd'],
            visibility:  km_to_mile(forecast_data['vis']), # TODO: May already be miles?
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
