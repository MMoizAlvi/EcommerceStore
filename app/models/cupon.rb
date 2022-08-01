class Cupon < ApplicationRecord
  belongs_to :order, optional: true
end
