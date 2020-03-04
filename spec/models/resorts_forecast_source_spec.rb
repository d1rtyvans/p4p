require 'rails_helper'

RSpec.describe ResortsForecastSource, :model do
  context 'Associations' do
    it { is_expected.to belong_to(:resort) }
    it { is_expected.to belong_to(:forecast_source) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:resort) }
    it { is_expected.to validate_presence_of(:forecast_source) }
  end
end
