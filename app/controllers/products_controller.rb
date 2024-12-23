# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :find_product, only: %i[show edit destroy update set_serial_no]
  after_action :set_serial_no, only: [:create]
  before_action :authorize_product, only: %i[destroy edit]

  def new
    @product = Product.new
  end

  def index
    search = params[:name].presence
    @products = if search
                  Product.search(search)
                else
                  Product.all
                end
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      flash[:notice] = 'Product created successfully!'
      redirect_to product_path(@product)
    else
      flash.now[:error] = "#{@product.errors.full_messages.to_sentence}"
      render :new
    end
  end

  def update
    @product.update(product_params)
    if @product.update(product_params)
      flash[:success] = 'Product successfully updated!'
      redirect_to product_path(@product)
    else
      flash.now[:error] = "#{@product.errors.full_messages.to_sentence}"
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to @product
  end

  def edit; end

  def show; end

  def autocomplete
    render json: Product.search(params[:query], {
                                  fields: ['name'],
                                  match: :words_start,
                                  limit: 10,
                                  load: false,
                                  misspellings: { below: 5 }
                                }).map(&:name)
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, imgs: [])
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def set_serial_no
    @product.serial_no = @product.id
    @product.save
  end

  def authorize_product
    authorize @product
  end
end
