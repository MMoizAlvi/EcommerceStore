class CommentsController < ApplicationController
  before_action :find_product, only: [  :create, :destroy, :edit, :show, :update ]
  before_action :find_comment, only: [ :edit, :show, :update, :destroy ]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @product.comments.new(comment_params)
    @comment.user_id = current_user.id
    authorize @comment
    respond_to do |format|
        if @comment.save
            format.html { redirect_to @product, notice: 'Comment was successfully created' }
            format.js
        else
            format.html { render :new }
            format.js
        end
    end
  end

  def update
    @comment.update(comment_params)
    if @comment.update(comment_params)
      flash[:success] = 'comment Updated successfully!'
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to product_path(@product)
  end

  def edit
  end

  def show
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_product
    @product = Product.find(params[:product_id])
  end

  def find_comment
    @comment = @product.comments.find(params[:id])
  end
end
