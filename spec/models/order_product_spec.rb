require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
  context 'Association Test' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:product) }
  end
end
