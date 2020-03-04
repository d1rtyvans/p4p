FactoryBot.define do
  factory :forecast do
    type   { 'DarkSkyForecast' }
    date   { Date.today }
    resort { create(:resort) }

    # TODO: Create better default for this factory when time permits
    weather_data  { {}.to_json }
  end
end
