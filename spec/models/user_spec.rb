require 'rails_helper'

RSpec.describe User, :model do
  context 'Associations' do
    it { is_expected.to have_many(:resorts).through(:favorites) }
  end

  context 'Validations' do
    describe 'presence' do
      it { is_expected.to validate_presence_of(:email) }
    end

    describe 'uniqueness' do
      before { create(:user) }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    end
  end
end
