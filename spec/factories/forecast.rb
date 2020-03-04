FactoryBot.define do
  factory :forecast do
    type   { 'DarkSkyForecast' }
    date   { Date.today }
    resort { create(:resort) }

    # TODO: Create better default for this factory when time permits
    weather_data do
      {
        hi_temp:     20.5,
        lo_temp:     1.5,
        precip_prob: 0,
        visibility:  10,
      }
    end
  end
end
