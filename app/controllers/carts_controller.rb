class CartsController < ApplicationController
  before_action :find_product, only: [ :create, :find_cart ]
  before_action :find_cart, only: [ :remove_from_cart, :update, :destroy, :create ]
  
  def new
    @cart = Cart.new(user: current_user)
  end

  def create
    cart_product = @cart.cart_products.build(cart: @cart, product: @product, quantity: 1)
    authorize @product
    if cart_product.save
      session[:cart_id] = @cart.id
      flash[:notice] = 'Added to cart!'
      redirect_to product_cart_path(@cart, @product)
    else
      render :new
    end
  end

  def remove_from_cart
    @cart = Cart.find(session[:cart_id])
    @cart_product = @cart.cart_products.find_by(product: params[:product])
    if @cart_product.destroy
      flash[:notice] = 'Product removed from cart!'
      redirect_to product_cart_path(@cart, params[:product])
    else
      render :edit
    end
  end

  def destroy
    @cart.destroy
  end

  def update
    @cart = Cart.find(session[:cart_id])
    @cart_product = @cart.cart_products.find_by(product: params[:product])
    @cart_product.quantity = params[:quantity]
    if @cart_product.save
      flash[:notice] = 'cart updated!'
      redirect_to product_cart_path(@cart, params[:product])
    else
      render :edit
    end
  end

  def show
    @cart = Cart.find(session[:cart_id])
  end

  private
  def find_cart
    @cart = Cart.find_or_create_by(user: current_user)
  end

  def find_product
    @product = Product.find(params[:product_id])
  end
end
