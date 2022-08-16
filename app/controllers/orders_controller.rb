# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :find_user_cart, only: %i[create]
  before_action :find_order, only: %i[create show]
  before_action :compute_user_order, only: %i[show]

  def new
    @order = Order.new(user: current_user)
  end

  def create
    if @order.save
      @order.products << @products
      flash[:notice] = 'Order Created!'
      redirect_to product_cart_order_path(@order, @cart, params[:product_id])
    else
      flash[:notice] = @order.errors.full_messages.to_sentence
      redirect_to products_path
    end
  end

  def show; end

  private

  def find_order
    if signed_in?
      @order = Order.find_or_create_by(user: current_user)
    else
      flash[:notice] = 'Please sign_in/sign_up first!'
      redirect_to user_session_path
    end
  end

  def find_user_cart
    @cart = assign_user_cart
    @products = @cart.products
  end

  def compute_user_order
    @cart = assign_user_cart
    @prices = @cart.products.pluck(:price)
    @quantity = @cart.cart_products.pluck(:quantity)
    @item_total = @prices.zip(@quantity).map { |pair| pair.reduce(&:*) }
    @order.total_amount = @item_total.sum
    @order.save
  end
end
