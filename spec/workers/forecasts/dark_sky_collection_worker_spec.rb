require 'rails_helper'

RSpec.describe Forecasts::DarkSkyCollectionWorker, :vcr do
  let(:resort) { create(:resort, :sierra) }

  describe '#perform_async' do
    subject { described_class.perform_async(resort.id) }

    it 'Collects resort specific data from Dark Sky API' do
      subject

      forecasts = resort.reload.forecasts

      expect(forecasts).to_not be_empty
      forecasts.each do |forecast|
        expect(forecast).to be_synced

        # TODO: Either test this more granularly elsewhere and keep this here,
        # or test it more granularly here. Another option could be validations
        # for presence on the jsonb column. Need to look into whether or not
        # that's possible/worth doing.
        payload = forecast.payload
        expect(payload['hi_temp']).to    be_a(Numeric)
        expect(payload['wind_speed']).to be_a(Numeric)
        expect(payload['visibility']).to be_a(Numeric)
      end
    end
  end
end