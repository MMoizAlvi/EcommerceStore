class ChangeProductSerialColumnConstraints < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:products, :serial_no, false)
  end
end
