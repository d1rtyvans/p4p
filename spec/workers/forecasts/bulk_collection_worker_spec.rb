require 'rails_helper'

RSpec.describe Forecasts::BulkCollectionWorker, :vcr do
  let(:resort) { create(:resort, :sierra) }

  describe '#perform_async' do
    subject { described_class.perform_async(resort.id) }

    it 'Collects resort specific forecast data from multiple sources and saves it in DB' do
      subject

      forecasts = resort.reload.forecasts
      expect(forecasts.size).to eq(described_class::FORECAST_SOURCES.size * 8)
    end

    context 'When forecasts already exist at dates' do
      let(:forecast) { create(:forecast, resort: resort) }

      before do
        # If this VCR cassette gets updated, update this date to Date.today.to_s
        stubbed_date = '2020-03-02'
        forecast.update!(updated_at: stubbed_date.to_date)
      end

      it 'Updates forecast data' do
        last_update = forecast.updated_at

        subject

        updated_forecast = forecast.reload
        expect(updated_forecast.updated_at).to be > last_update
      end
    end
  end
end
