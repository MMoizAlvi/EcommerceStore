class RemoveCuponFromOrder < ActiveRecord::Migration[5.2]
  def change
    remove_reference :orders, :cupon, foreign_key: true
  end
end
