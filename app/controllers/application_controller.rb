# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
    before_action :configure_permitted_parameters,
                  if: :devise_controller?
    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit(:email, :first_name, :last_name, :password, :password_confirmation, :avatar)
      end
      devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
    end

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

    private

    def record_not_found
      redirect_to root_url
    end

    def user_not_authorized
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to(request.referer || root_path)
    end

    def cart
      if signed_in?
        @cart = Cart.find_by(id: session[:cart_id])
        if @cart.nil?
          @cart = Cart.create
          session[:cart_id] = @cart.id
          @cart
        else
          @cart
        end
      elsif session[:cart_id]
        @cart = Cart.find(session[:cart_id])
      else
        @cart = Cart.create
        session[:cart_id] = @cart.id
        @cart
      end
    end
end
