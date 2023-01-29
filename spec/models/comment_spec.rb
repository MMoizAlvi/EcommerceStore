require 'rails_helper'

RSpec.describe Comment, type: :model do
 context 'Association Test' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:product) }
  end

  context 'validations for comment body' do
    it { is_expected.to validate_presence_of(:body) }
  end
end
