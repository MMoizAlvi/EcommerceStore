class AddOrderToCupon < ActiveRecord::Migration[5.2]
  def change
    add_reference :cupons, :order, foreign_key: true, null: true
  end
end
