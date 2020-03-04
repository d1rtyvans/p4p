require 'rails_helper'

RSpec.describe Api::V1::ForecastsController, :controller do
  subject { get :index, params: { resort_id: resort.uid } }
  let(:resort) { create(:resort, :with_forecasts) }

  it 'Responds with average forecast data for each upcoming day' do
    # Smoke check, will get more granular later/elsewhere
    expected_keys = %w[
      date
      agg_precip_type
      avg_precip_prob
      avg_hi_temp
      avg_lo_temp
      avg_vis
      avg_wind_spd
      avg_snow_depth
      avg_snowfall
    ]

    response = subject

    expect(response.code).to eq('200')

    response_body = JSON.parse(response.body)['forecasts']
    expect(response_body).to_not be_empty

    response_body.each do |forecast|
      expect(forecast.keys).to contain_exactly(*expected_keys)
    end
  end
end
