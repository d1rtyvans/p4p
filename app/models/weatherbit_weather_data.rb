# This is used to typecast and validate the jsonb column `weather_data` for
# WeatherbitForecasts. This allows us to have very descriptive validation errors if
# we get an unexpected response from the Weatherbit API, as well as a nice
# interface allowing us to leverage Rails' attributes API
class WeatherbitWeatherData
  include StoreModel::Model

  # See if possible to round float to 2 decimal points...
  attribute :hi_temp,     :float
  attribute :lo_temp,     :float
  attribute :precip_prob, :float
  attribute :snow_depth,  :float
  attribute :snowfall,    :float
  attribute :visibility,  :float
  attribute :wind_speed,  :float

  # TODO: Test and research which of these will always be returned by Weatherbit...
  validates :hi_temp, presence: true
  validates :lo_temp, presence: true
end
