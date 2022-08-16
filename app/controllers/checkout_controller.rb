class CheckoutController < ApplicationController
  before_action :find_order, only: [:create, :destroy_order]
  # around_action :destroy_order, only: [:create]

  def create
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        name: current_user.email,
        amount: @order.total_amount.to_i,
        currency: 'usd',
        quantity: 1,
      }],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
    })
    redirect_to @session.url and return
  end

  def destroy_order
    if @order.destroy
      current_user.cart.destroy
      current_user.cart.cart_products.destroy
      Cart.find(session[:cart_id]).destroy
      flash[:notice] = 'Order Destroy'
    else
      flash[:notice] = 'Order id missing'
    end
  end

  private

  def find_order
    @order = Order.find(params[:order_id])
  end
end
