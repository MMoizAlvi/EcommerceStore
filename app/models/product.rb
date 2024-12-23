# frozen_string_literal: true

class Product < ApplicationRecord
  searchkick
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :order_products, dependent: :destroy
  has_many :orders, through: :order_products
  has_many_attached :imgs, dependent: :destroy
  has_many :cart_products, dependent: :destroy
  has_many :carts, through: :cart_products

  validates :name, :price, :description, presence: true
  validates :name, length: { in: 3..10 }
  validates :description, length: { in: 5..40 }
  validates :price, numericality: { greater_than: 0, less_than: 1_000_000 }
end
