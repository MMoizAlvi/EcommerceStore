# frozen_string_literal: true

class CreateCartOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_orders do |t|
      t.references :cart, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
