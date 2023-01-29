class ChangeCartProductColumnConstraint < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:cart_products, :cart_id, false)
    change_column_null(:cart_products, :product_id, false)
  end
end
