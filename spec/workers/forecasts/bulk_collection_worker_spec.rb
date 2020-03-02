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
  end
end
