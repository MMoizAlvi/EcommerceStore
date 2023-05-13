require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  context 'validations for name' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  context 'Association Test' do
    it { is_expected.to have_many(:products).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:orders).dependent(:destroy) }
    it { is_expected.to have_one(:cart).dependent(:destroy) }
    it { is_expected.to have_one_attached(:avatar) }
  end

  describe '.avatar_thumbnail' do
    it 'user has avatar attached' do
      user.send(:avatar_thumbnail)
      expect(user.avatar.key).to be_truthy
    end

    it 'user has not avatar attached' do
      user = build(:user)
      user.avatar = nil
      user.send(:avatar_thumbnail)
      expect(user.errors.messages).to eq({})
    end
  end
end
