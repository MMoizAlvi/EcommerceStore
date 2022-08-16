class ApplicationController < ActionController::Base
  include Pundit
  # before_action :set_session
  before_action :configure_permitted_parameters,
    if: :devise_controller?

      protected

      # def configure_permitted_parameters
      #   devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
      #   devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
      # end
      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit(:email, :first_name, :last_name, :password, :password_confirmation)
      end
    end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  # def set_session
  #   @cart = Cart.new
  #   if signed_in?
  #     @cart.user_id = current_user.id
  #   end
  #   @cart.save
  #   session[:cart_id] ||= @cart.id
  # end
end
