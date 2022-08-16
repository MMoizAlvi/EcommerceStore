class AddQuantityToCartProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_products, :quantity, :integer, default: 0
  end
end
