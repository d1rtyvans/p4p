require 'rails_helper'

RSpec.describe Forecasts::WeatherbitCollectionWorker, :vcr do
  let(:resort) { create(:resort, :sierra) }

  describe '#perform_async' do
    subject { described_class.perform_async(resort.id) }

    it 'Collects resort specific data from Weatherbit.io API' do
      subject

      forecasts = resort.reload.forecasts

      expect(forecasts).to_not be_empty
      forecasts.each do |forecast|
        expect(forecast).to be_synced

        payload = forecast.payload
        expect(payload['hi_temp']).to     be_a(Numeric)
        expect(payload['lo_temp']).to     be_a(Numeric)
        expect(payload['precip_prob']).to be_a(Numeric)
        expect(payload['snow_depth']).to  be_a(Numeric)
        expect(payload['snowfall']).to    be_a(Numeric)
        expect(payload['wind_speed']).to  be_a(Numeric)
        expect(payload['visibility']).to  be_a(Numeric)
      end
    end
  end
end
