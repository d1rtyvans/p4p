require 'rails_helper'

RSpec.describe Forecast, :model do
  describe '.resort_aggregate' do
    subject { described_class.resort_aggregate(resort.uid) }
    let(:resort) { create(:resort, :with_forecasts) }

    it "Returns a Resort's aggregate forecast data for each upcoming day." do
      # TODO: Build a more dynamic expectation based on values that vary a
      # bit more. This is a good enough smoke check for now.
      expected_output = {
        'forecasts' => [
          {'date'=>'2020-03-04', 'agg_precip_type'=>'snow', 'avg_precip_prob'=>8, 'avg_hi_temp'=>19, 'avg_lo_temp'=>2, 'avg_vis'=>10, 'avg_wind_spd'=>3, 'avg_snow_depth'=>12, 'avg_snowfall'=>5},
          {'date'=>'2020-03-05', 'agg_precip_type'=>'snow', 'avg_precip_prob'=>8, 'avg_hi_temp'=>19, 'avg_lo_temp'=>2, 'avg_vis'=>10, 'avg_wind_spd'=>3, 'avg_snow_depth'=>12, 'avg_snowfall'=>5},
          {'date'=>'2020-03-06', 'agg_precip_type'=>'snow', 'avg_precip_prob'=>8, 'avg_hi_temp'=>19, 'avg_lo_temp'=>2, 'avg_vis'=>10, 'avg_wind_spd'=>3, 'avg_snow_depth'=>12, 'avg_snowfall'=>5}
        ]
      }

      output = JSON.parse(subject.to_json)
      expect(output).to eq(expected_output)
    end
  end

  context 'Associations' do
    it { is_expected.to belong_to(:resort) }
  end

  context 'Validations' do
    describe 'presence' do
      attrs = %i[
        type
        date
        weather_data
      ]

      attrs.each do |attr|
        it { is_expected.to validate_presence_of(attr) }
      end
    end
  end
end
