class ChangeProductColumnConstraints < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:products, :name, false)
    # change_column(:products, :serial_no, :integer, unique: true)
    change_column_null(:products, :price, false)
    change_column_null(:products, :description, false)
    change_column_null(:products, :user_id, false)
  end
end
