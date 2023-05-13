# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :find_user_cart, only: %i[create]
  before_action :find_order, only: %i[create show find_cupon]
  before_action :compute_user_order, only: %i[show ]

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

  def find_cupon
    cupon = Cupon.find_by(promo_code: params[:promo_code])
    if !cupon.nil? && cupon.valid_til > Time.zone.now && params[:promo_code].match(/^\d*[A-Z][A-Z0-9]*$/)
      @valid_cupon = cupon
      @order.discounted_amount = @order.total_amount.to_i * @valid_cupon.discount_rate / 100
      @order.discounted_amount = @order.total_amount.to_i - @order.discounted_amount
      @order.save
    else
      flash[:notice] = 'Invalid Promo code!'
    end
    redirect_to product_cart_order_path(@order, params[:cart_id], params[:product_id])
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
