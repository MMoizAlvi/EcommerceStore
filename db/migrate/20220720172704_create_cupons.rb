# frozen_string_literal: true

class CreateCupons < ActiveRecord::Migration[5.2]
  def change
    create_table :cupons do |t|
      t.string :promo_code
      t.integer :discount_rate
      t.datetime :valid_til

      t.timestamps
    end
  end
end
