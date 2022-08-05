class ChangeOrderColumnConstraint < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:orders, :user_id, false)
  end
end
