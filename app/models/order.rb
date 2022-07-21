class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product, through: :order_products
  has_one :cupon
end
