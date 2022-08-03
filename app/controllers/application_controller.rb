# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  before_action :create_cart, if :carts_controller?
  before_action :configure_permitted_parameters,
                if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :first_name, :last_name, :password, :password_confirmation)
    end
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end

  def create_cart
    if signed_in?
      @cart = Cart.find(session[:cart_id])
      @cart.user_id ||= current_user.id
    else
      if !Cart.find_by(id: session[:cart_id]).nil?
        @cart = Cart.find(session[:cart_id])
      else
        @cart = Cart.create(id: session[:cart_id])
        session[:cart_id] = @cart.id
      end
    end
  end
end
end
