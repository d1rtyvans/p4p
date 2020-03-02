FactoryBot.define do
  factory :forecast do
    type                { 'DarkSkyForecast' }
    date                { Date.today }
    resort              { create(:resort) }
    last_update         { Time.current }
    last_update_attempt { Time.current }
    status              { 'synced' }
  end
end
