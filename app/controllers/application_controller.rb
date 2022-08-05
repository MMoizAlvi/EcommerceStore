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
      devise_parameter_sanitizer.permit(:account_update) do |user_params|
        user_params.permit(:email, :first_name, :last_name, :avatar)
      end
    end

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

    private

    def new_cart
      @cart = Cart.create
      session[:cart_id] = @cart.id
      @cart
    end

    def record_not_found
      redirect_to root_url
    end

    def user_not_authorized
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to(request.referer || root_path)
    end

    def assign_user_cart
      if signed_in?
        @cart = Cart.find_by(id: session[:cart_id])
        if @cart.nil?
          new_cart
        end
      elsif session[:cart_id]
        @cart = Cart.find(session[:cart_id])
      else
        new_cart
      end
      @cart
    end
end
