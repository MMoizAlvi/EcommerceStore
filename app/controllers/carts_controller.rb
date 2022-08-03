# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :find_product, only: %i[create]
  before_action :user_cart, only: %i[remove_from_cart show update create]
  before_action :find_cart_products, only: %i[remove_from_cart update]

  def create
    cart_product = @cart.cart_products.build(cart: @cart, product: @product, quantity: 1)
    authorize @product
    if cart_product.save
      flash[:notice] = 'Added to cart!'
      redirect_to product_cart_path(@cart, @product)
    else
      flash[:notice] = 'Failed to add to cart!'
      render :new
    end
  end

  def remove_from_cart
    if @cart_product.destroy
      flash[:notice] = 'Product removed from cart!'
      redirect_to product_cart_path(@cart, params[:product])
    else
      flash[:notice] = 'Failed to remove from cart!'
      render :edit
    end
  end

  def update
    @cart_product.quantity = params[:quantity]
    if @cart_product.save
      flash[:notice] = 'cart updated!'
      redirect_to product_cart_path(@cart, params[:product])
    else
      flash[:notice] = 'Failed to update cart!'
      render :edit
    end
  end

  def show
    if @cart.nil?
      flash[:notice] = 'Your cart is empty!'
      redirect_to products_path
    end
  end

  private
  def user_cart
    @cart = Cart.find_by(id: session[:cart_id])
  end

  def find_product
    @product = Product.find(params[:product_id])
  end

  def find_cart_products
    @cart_product = @cart.cart_products.find_by(product: params[:product])
  end
end
