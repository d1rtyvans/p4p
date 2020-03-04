require 'rails_helper'

RSpec.describe Day, :model do
  context 'Associations' do
    it { is_expected.to belong_to(:resort) }
    it { is_expected.to belong_to(:forecast_source) }
  end

  context 'Validations' do
    describe 'presence' do
      attrs = %i[
        resort
        forecast_source
        type
        date
        weather_data
        last_update
      ]

      attrs.each do |attr|
        it { is_expected.to validate_presence_of(attr) }
      end
    end
  end
end
