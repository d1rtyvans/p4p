require 'rails_helper'

RSpec.describe Outage, :model do
  context 'Associations' do
    it { is_expected.to belong_to(:forecast_source) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:error_data) }
  end
end
