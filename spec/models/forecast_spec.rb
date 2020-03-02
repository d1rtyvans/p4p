require 'rails_helper'

RSpec.describe Forecast, :model do
  context 'Associations' do
    it { is_expected.to belong_to(:resort) }
  end

  context 'Enumerable values' do
    it do
      statuses = %i[
        pending
        synced
        error
      ]

      is_expected.to define_enum_for(:status).with_values(statuses)
    end
  end


  context 'Validations' do
    describe 'presence' do
      attrs = %i[
        type
        date
        payload
        status
      ]

      attrs.each do |attr|
        it { is_expected.to validate_presence_of(attr) }
      end
    end
  end
end
