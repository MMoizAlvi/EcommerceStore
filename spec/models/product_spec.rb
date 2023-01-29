require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product, user: user) }

  context 'validations for product name' do
    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_length_of(:name).is_at_least(3).on(:create) }
    it { is_expected.to validate_length_of(:name).is_at_most(10).on(:create) }
  end

  context 'validations for product description' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_least(5).on(:create)}
    it { is_expected.to validate_length_of(:description).is_at_most(40).on(:create) }
  end

  context 'validations for product price' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_less_than(1000000).on(:create) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0).on(:create) }
  end

  context 'Association Test' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:order_products).dependent(:destroy) }
    it { is_expected.to have_many(:orders).through(:order_products) }
    it { is_expected.to have_many(:cart_products).dependent(:destroy) }
    it { is_expected.to have_many(:carts).through(:cart_products) }
    it { is_expected.to have_many_attached(:imgs) }
  end

  describe '.text_search' do
    it 'query found' do
      Product.send(:text_search, :query)
      expect(product).to be_valid
    end

    it 'query not found' do
      Product.send(:text_search, false)
      expect(product).to be_valid
    end
  end
end
