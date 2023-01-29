require 'rails_helper'

RSpec.describe Cart, type: :model do
 context 'Association Test' do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to have_many(:cart_products).dependent(:destroy) }
    it { is_expected.to have_many(:products).through(:cart_products) }
  end
end
