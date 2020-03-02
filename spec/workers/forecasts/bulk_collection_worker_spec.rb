require 'rails_helper'

RSpec.describe Forecasts::BulkCollectionWorker, :vcr do
  let(:resort) { create(:resort, :sierra) }

  describe '#perform_async' do
    subject { described_class.perform_async(resort.id) }

    it 'Collects resort specific forecast data from multiple sources and saves it in DB' do
      subject

      forecasts = resort.reload.forecasts
      expect(forecasts.size).to eq(described_class::FORECAST_SOURCES.size * 8)

      forecasts.each do |forecast|
        expect(forecast).to be_synced
      end
    end

    context 'When forecasts already exist at dates' do
      let(:forecast) { create(:forecast, resort: resort, status: 'error') }

      it 'Updates forecast data' do
        last_update = forecast.last_update

        subject

        updated_forecast = forecast.reload
        expect(updated_forecast).to             be_synced
        expect(updated_forecast.last_update).to be > last_update
      end
    end
  end
end
