class CreateJoinTableOrderPost < ActiveRecord::Migration[5.2]
  def change
    create_join_table :orders, :posts do |t|
      # t.index [:order_id, :post_id]
      # t.index [:post_id, :order_id]
    end
  end
end
