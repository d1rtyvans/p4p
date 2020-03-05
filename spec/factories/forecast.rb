FactoryBot.define do
  factory :forecast do
    type   { 'DarkSkyForecast' }
    date   { Date.today }
    association :resort

    # TODO: Create better default for this factory when time permits,
    # maybe a bit of randomness or a range of possible values for each.
    weather_data do
      {
        hi_temp:     20,
        lo_temp:     2,
        precip_prob: 5,
        precip_type: 'snow',
        visibility:  10,
        wind_speed:  2,
      }
    end

    trait :weatherbit do
      type { 'WeatherbitForecast' }

      weather_data do
        {
          hi_temp:     18,
          lo_temp:     1,
          precip_prob: 10,
          visibility:  9,
          snow_depth:  12,
          snowfall:    5,
          wind_speed:  4,
        }
      end
    end
  end
end
