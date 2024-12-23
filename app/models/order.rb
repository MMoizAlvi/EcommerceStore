# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products, dependent: :delete_all
  has_many :products, through: :order_products
  has_one :cupon
  has_many :cart_orders, dependent: :destroy
  has_many :carts, through: :cart_orders
end
