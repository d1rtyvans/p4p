module Forecasts
  class DarkSkyCollector
    attr_reader :client

    def initialize(options)
      @resort_id = options.fetch(:resort_id)
      @coords    = options.fetch(:coords)
      @client    = DarkSkyClient.new
    end

    def do!
      with_error_handling do
        forecasts = format_data(get_forecasts)
        upsert_forecasts!(forecasts)
      end
    end

    private

    def upsert_forecasts!(forecasts)
      # Create or update weather_data for forecasts matching date, type, and
      # resort. Until performance becomes an issue, this will be done 1 by 1
      # instead of #upsert_all because it allows us to take advantage of
      # ActiveRecord callbacks and validations.
      DarkSkyForecast.transaction do
        forecasts.each do |forecast_data|
          identifiers = {
            resort_id: @resort_id,
            date:      forecast_data[:date],
          }

          forecast = DarkSkyForecast.find_or_initialize_by(identifiers)
          forecast.update!(weather_data: forecast_data[:weather_data])
        end
      end
    end

    def get_forecasts
      client.forecast(@coords)
    end

    def format_data(forecasts)
      forecasts.map do |forecast_data|
        {
          date:                unix_time_to_date(forecast_data['time']),
          weather_data: {
            hi_temp:         forecast_data['temperatureHigh'],
            lo_temp:         forecast_data['temperatureLow'],
            accumulation_cm: forecast_data['precipAccumulation'], # cm
            precip_prob:     pct_to_int(forecast_data['precipProbability']),
            precip_type:     forecast_data['precipType'], # "rain", "snow", "sleet", nil
            visibility:      forecast_data['visibility'],
            wind_speed:      forecast_data['windSpeed'],  # MPH
          }
        }
      end
    end

    def with_error_handling
      # TODO: Error handling
      yield
    end

    # TODO: Extract these two out and test
    def pct_to_int(pct)
      (pct * 100).to_i
    end

    def unix_time_to_date(unix_time)
      Time.at(unix_time).to_date
    end
  end
end
