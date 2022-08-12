require 'rails_helper'

RSpec.describe CartProduct, type: :model do
 context 'Association Test' do
    it { is_expected.to belong_to(:cart) }
    it { is_expected.to belong_to(:product) }
  end
end
