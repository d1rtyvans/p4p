require 'rails_helper'

RSpec.describe Resort, :model do
  context 'Associations' do
    it { is_expected.to have_many(:users).through(:favorites) }
  end

  context 'Validations' do
    describe 'presence' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:uid) }
      it { is_expected.to validate_presence_of(:lat) }
      it { is_expected.to validate_presence_of(:lon) }
    end

    describe 'uniqueness' do
      before { create(:resort) }
      it { is_expected.to validate_uniqueness_of(:uid).case_insensitive }
    end
  end
end
