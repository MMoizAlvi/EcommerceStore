# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products
  has_many :cart_orders, dependent: :destroy
  has_many :orders, through: :cart_orders
end
