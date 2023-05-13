module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
    end
  end

  RSpec.configure do |config|
    config.extend ControllerMacros, :type => :controller
  end
end
