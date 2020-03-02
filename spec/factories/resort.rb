FactoryBot.define do
  factory :resort do
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
  end
end
