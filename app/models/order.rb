# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products, dependent: :delete_all
  has_many :products, through: :order_products
  has_one :cupon
end
