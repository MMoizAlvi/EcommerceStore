class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit]

  def new
    @product = Product.new
  end

  def index
    @products = Product.all
  end

  def edit
  end

  def show
  end

  def find_product
    @product =  Product.find(params[:id])
  end

  def create
    @product = current_user.products.create(product_params)
    if @product.save
      flash[:success] = 'Product created successfully!'
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def update
    @product = current_user.products.find(params[:id])
    @product.update(product_params)
    if @product.update(product_params)
      flash[:success] = 'Product successfully updated!'
      redirect_to product_path(@product)
    else
      flash[:error] = 'Something went wrong'
      render :edit
    end
  end

  def destroy
    @product = current_user.products.find(params[:id])
    @product.destroy
    redirect_to new_products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description)
  end
end
