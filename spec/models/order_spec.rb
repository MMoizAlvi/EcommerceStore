require 'rails_helper'

RSpec.describe Order, type: :model do
 context 'Association Test' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:order_products).dependent(:delete_all) }
    it { is_expected.to have_many(:products).through(:order_products) }
    it { is_expected.to have_one(:cupon) }
  end
end
