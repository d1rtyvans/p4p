require 'rails_helper'

RSpec.describe Forecast, :model do
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
