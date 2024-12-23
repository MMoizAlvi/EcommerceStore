# frozen_string_literal: true

class Cupon < ApplicationRecord
  belongs_to :order, optional: true
end
