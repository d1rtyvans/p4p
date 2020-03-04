require 'rails_helper'

RSpec.describe Forecasts::DarkSkyCollectionWorker, :vcr do
  let(:resort) { create(:resort, :sierra) }

  describe '#perform_async' do
    subject { described_class.perform_async(resort.id) }

    it 'Collects resort specific data from Dark Sky API' do
      subject

      forecasts = resort.reload.forecasts

      expect(forecasts).to_not be_empty
      forecasts.pluck(:weather_data).each do |weather_data|
        expect(weather_data).to                have_key('precip_type')
        expect(weather_data).to                have_key('accumulation_cm')
        expect(weather_data['hi_temp']).to     be_a(Numeric)
        expect(weather_data['lo_temp']).to     be_a(Numeric)
        expect(weather_data['precip_prob']).to be_a(Numeric)
        expect(weather_data['wind_speed']).to  be_a(Numeric)
        expect(weather_data['visibility']).to  be_a(Numeric)
      end
    end
  end
end
