FactoryBot.define do
  factory :resort do
    sequence(:uid) { |i| "resort_#{i}" }

    name { Faker::Name.name }
    lat  { 38.8009 }
    lon  { -120.0809 }
  end
end
