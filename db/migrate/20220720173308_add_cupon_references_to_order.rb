class AddCuponReferencesToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :cupon, foreign_key: true
  end
end
