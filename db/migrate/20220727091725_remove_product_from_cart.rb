class RemoveProductFromCart < ActiveRecord::Migration[5.2]
  def change
    remove_reference :carts, :product, foreign_key: true
  end
end
