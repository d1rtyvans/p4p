require 'rails_helper'

RSpec.describe ForecastSource, :model do
  context 'Associations' do
    it { is_expected.to have_many(:outages) }
    it { is_expected.to have_many(:resorts).through(:resorts_forecast_sources) }
  end

  context 'Validations' do
    describe 'presence' do
      attrs = %i[
        name
        klass_name
      ]
    end
  end

  context 'Enumerable values' do
    it do
      statuses = %i[
        online
        down
      ]

      is_expected.to define_enum_for(:status).with_values(statuses)
    end
  end
end
