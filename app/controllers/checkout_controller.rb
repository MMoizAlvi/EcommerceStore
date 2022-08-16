# frozen_string_literal: true

class CheckoutController < ApplicationController
  before_action :find_order, only: %i[create compute_total find_cupon]
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
    @order = Order.find(params[:order_id])
  end

  def compute_total
    @total = if @order.discounted_amount.to_i.positive?
               @order.discounted_amount.to_i
             else
               @order.total_amount.to_i
             end
  end
end
