class DarkSkyForecast < Forecast
  # Provides model-like validations for jsonb column :weather_data
  attribute :weather_data, DarkSkyWeatherData.to_type
  validates :weather_data, store_model: true
end
