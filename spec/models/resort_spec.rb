require 'rails_helper'

RSpec.describe Resort, :model do
  let(:resort) { build(:resort) }

  describe '#coords'do
    subject { resort.coords }
    it { is_expected.to eq([resort.lat, resort.lon]) }
  end

  context 'Associations' do
    it { is_expected.to have_many(:forecasts) }
    it { is_expected.to have_many(:users).through(:favorites) }
  end

  context 'Validations' do
    describe 'uniqueness' do
      before { create(:resort) }
      it { is_expected.to validate_uniqueness_of(:uid).case_insensitive }
    end

    describe 'presence' do
      attrs = %i[
        name
        uid
        lat
        lon
      ]

      attrs.each do |attr|
        it { is_expected.to validate_presence_of(attr) }
      end
    end
  end
end
