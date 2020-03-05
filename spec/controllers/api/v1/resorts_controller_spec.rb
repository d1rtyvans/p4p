require 'rails_helper'

RSpec.describe Api::V1::ResortsController, :controller, :vcr do
  describe '#create' do
    subject { post :create, params: resort_payload }
    let(:resort_payload) do
      {
        resort: {
          uid: 'alpine',
          name: 'Alpine Meadows',
          lat: 39.1646,
          lon: -120.2387,
        }
      }
    end

    it 'Creates a resort and collects forecast data in the background' do
      response = subject

      expect(response.code).to eq('201')
      response_body = JSON.parse(response.body)

      expect(response_body['id']).to_not be_nil
      expect(response_body['uid']).to eq(resort_payload[:resort][:uid])
      expect(response_body['name']).to eq(resort_payload[:resort][:name])

      coords = [resort_payload[:resort][:lat], resort_payload[:resort][:lon]]
      expect(response_body['coords']).to eq(coords)

      # Should enqueue job to collect forecasts for new resort
      forecasts = Resort.find(response_body['id']).forecasts
      expect(forecasts).to_not be_empty
    end
  end
end
