class Product < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :orders, through: :order_products
end
