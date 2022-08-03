# frozen_string_literal: true

class CartOrder < ApplicationRecord
  belongs_to :cart
  belongs_to :order
end
