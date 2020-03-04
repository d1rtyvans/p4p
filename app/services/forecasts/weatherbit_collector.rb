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
      # Create or update weather_data for forecasts matching date, type, and
      # resort. Until performance becomes an issue, this will be done 1 by 1
      # instead of #upsert_all because it allows us to take advantage of
      # ActiveRecord callbacks and validations.
      WeatherbitForecast.transaction do
        forecasts.each do |forecast_data|
          identifiers = {
            resort_id: @resort_id,
            date:      forecast_data[:date],
          }

          forecast = WeatherbitForecast.find_or_initialize_by(identifiers)
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
          date: unix_time_to_date(forecast_data['ts']),
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
      yield
    rescue StandardError => e
      # TODO: More robust error handling for specific cases. Will eventually
      # break these down by parent class, ActiveRecord, WeatherbitClient..
      # Retrying some errors and not others, etc.
      err_message = "#{e.class} - #{e.message}"
      Rails.logger.error('Error while collecting forecast data from Weatherbit: ' + err_message.inspect)
      outage!(e)
    end

    def outage!(e)
      # TODO: Track outages for specific Forecast sources to display warning
      # to user.. Possibly use Redis for this...
    end

    def km_to_mile(kms)
      # Caps out at 10 mi
      return 10 if kms == 15

      # This is close enough for what we're using it for. Don't need to store the
      # extra decimals, if a time comes when we need that exact data this can
      # always be updated
      (kms * 0.62).round(2)
  end

    def unix_time_to_date(unix_time)
      Time.at(unix_time).to_date
    end
  end
end
