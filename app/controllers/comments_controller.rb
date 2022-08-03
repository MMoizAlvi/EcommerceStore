# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_product, only: %i[create destroy edit show update]
  before_action :find_comment, only: %i[edit show update destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @product.comments.new(comment_params)
    authorize @comment
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @product, notice: 'Comment was successfully created' }
      else
        format.html { render :new, notice: 'Failed to generate comment' }
      end
      format.js
    end
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'comment updated successfully!'
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      flash[:notice] = 'comment deleted successfully!'
      redirect_to product_path(@product)
    else
      flash[:notice] = 'Failed to delete a comment!'
      render :edit
    end
  end

  def edit; end

  def show; end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end

  def find_product
    @product = Product.find(params[:product_id])
  end

  def find_comment
    @comment = @product.comments.find(params[:id])
  end
end
