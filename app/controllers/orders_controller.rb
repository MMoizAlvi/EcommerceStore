# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :find_user_cart, only: %i[create destroy]
  before_action :find_order, only: %i[create destroy show find_cupon]
  before_action :compute_user_order, only: [:show]

  def new
    @order = Order.new(user: current_user)
  end

  def create
    if @order.save
      @order.products << @products
      cart_order = @order.cart_orders.create(cart: @cart, order_id: @order)
      flash[:notice] = 'Order Created!'
      redirect_to product_cart_order_path(@order, @cart, params[:product_id])
    else
      render :new
    end
  end

  def show; end

  def find_cupon
    cupon = Cupon.find_by(promo_code: params[:promo_code])
    if !cupon.nil? && cupon.valid_til > Time.zone.now && params[:promo_code].match(/^\d*[A-Z][A-Z0-9]*$/)
      @valid_cupon = cupon
      @order.discounted_amount = @order.total_amount * @valid_cupon.discount_rate / 100
      @order.discounted_amount = @order.total_amount - @order.discounted_amount
      @order.save
    else
      flash[:notice] = 'Invalid Promo code!'
    end
    redirect_to product_cart_order_path(@order, params[:cart_id], params[:product_id])
  end

  private

  def find_order
    if signed_in?
      @order = Order.find_or_create_by(user: current_user)
    else
      flash[:notice] = 'Please sign_in/sign_up first!'
      redirect_to user_registration_path
    end
  end

  def find_user_cart
    @cart = Cart.find(session[:cart_id])
    @products = @cart.products
  end

  def compute_user_order
    @cart = Cart.find(session[:cart_id])
    @prices = @cart.products.pluck(:price)
    @quantity = @cart.cart_products.pluck(:quantity)
    @item_total = @prices.zip(@quantity).map { |pair| pair.reduce(&:*) }
    @order.total_amount = @item_total.sum
    @order.save
  end
end
