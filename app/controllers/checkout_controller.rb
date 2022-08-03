# frozen_string_literal: true

class CheckoutController < ApplicationController
  before_action :find_order, only: %i[create compute_total]
  before_action :compute_total, only: %i[create]

  def create
    @session = Stripe::Checkout::Session.create({
                                                  payment_method_types: ['card'],
                                                  line_items: [{
                                                    name: current_user.email,
                                                    amount: @total,
                                                    currency: 'usd',
                                                    quantity: 1
                                                  }],
                                                  mode: 'payment',
                                                  success_url: root_url,
                                                  cancel_url: root_url
                                                })
    redirect_to @session.url and return
  end

  private

  def find_order
    @order = Order.find(params[:order_id])
  end

  def compute_total
    if @order.discounted_amount.to_i > 0
      @total = @order.discounted_amount.to_i
    else
      @total = @order.total_amount.to_i
    end
  end
end
