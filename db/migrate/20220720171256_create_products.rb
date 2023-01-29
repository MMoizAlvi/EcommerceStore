# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :serial_no
      t.string :name
      t.float :price
      t.text :description
      t.string :images
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
