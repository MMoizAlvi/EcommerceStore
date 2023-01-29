class ChangeOrderProductColumnConstraint < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:order_products, :order_id, false)
    change_column_null(:order_products, :product_id, false)
  end
end
