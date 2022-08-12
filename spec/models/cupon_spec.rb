require 'rails_helper'

RSpec.describe Cupon, type: :model do
 context 'Association Test' do
    it { is_expected.to belong_to(:order).optional }
  end
end
