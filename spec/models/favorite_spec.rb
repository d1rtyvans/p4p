require 'rails_helper'

RSpec.describe Favorite, :model do
  context 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:resort) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:resort) }
  end
end
