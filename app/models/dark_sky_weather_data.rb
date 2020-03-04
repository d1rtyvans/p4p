# This is used to typecast and validate the jsonb column `weather_data` for
# DarkSkyForecasts. This allows us to have very descriptive validation errors if
# we get an unexpected response from the Dark Sky API, as well as a nice
# interface allowing us to leverage Rails' attributes API
class DarkSkyWeatherData
  include StoreModel::Model

  attribute :hi_temp,         :float
  attribute :lo_temp,         :float
  attribute :accumulation_cm, :float
  attribute :precip_prob,     :float
  attribute :precip_type,     :string
  attribute :visibility,      :float
  attribute :wind_speed,      :float

  # TODO: Test and research which of these will always be returned by Dark Sky...
  validates :hi_temp, presence: true
  validates :lo_temp, presence: true
end
