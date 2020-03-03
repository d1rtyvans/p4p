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
      # TODO: Error handling
      DarkSkyForecast.upsert_all(forecasts,
                                 unique_by: [:resort_id, :date, :type])
    end

    def get_forecasts
      client.forecast(@coords)
    end

    def format_data(forecasts)
      timestamp = Time.current
      forecasts.map do |forecast_data|
        {
          date:                unix_time_to_date(forecast_data['time']),
          resort_id:           @resort_id,
          last_update:         timestamp,
          last_update_attempt: timestamp,
          status:              1, # TODO: Convert
          type:                'DarkSkyForecast',
          created_at:          timestamp,
          updated_at:          timestamp,
          payload: {
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
