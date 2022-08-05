class ChangeCommentColumnConstraints < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:comments, :body, false)
    change_column_null(:comments, :product_id, false)
    change_column_null(:comments, :user_id, false)
  end
end
