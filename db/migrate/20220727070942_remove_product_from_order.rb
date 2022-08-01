class RemoveProductFromOrder < ActiveRecord::Migration[5.2]
  def change
    remove_reference :orders, :product, foreign_key: true
  end
end
