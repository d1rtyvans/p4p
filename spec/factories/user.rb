FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "shredder#{i}@ripit.net" }
  end
end
