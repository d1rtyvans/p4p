FactoryBot.define do
  factory :resort do
    # TODO: Use faker unique with a 'test' namespace
    sequence(:uid) { |i| "resort_#{i}" }

    name { Faker::Name.name }
    lat  { 43.5875 }
    lon  { -110.8279 }

    trait :sierra do
      uid  { 'sierra' }
      name { 'Sierra at Tahoe' }
      lat  { 38.8009 }
      lon  { -120.0809 }
    end

    trait :with_forecasts do
      # Create 3 days worth of forecasts for each default forecast source
      # This is mostly used to check forecast aggregation calculations
      after(:create) do |resort|
        forecasts = []

        (Date.today..2.days.from_now).to_a.each do |date|
          # 'type' defaults to 'DarkSkyForecast', may require this to be
          # explicit in the future...
          forecasts.push(
            build(:forecast, date: date, resort: resort),
            build(:forecast, :weatherbit, date: date, resort: resort))
        end

        resort.update!(forecasts: forecasts)
      end
    end
  end
end
