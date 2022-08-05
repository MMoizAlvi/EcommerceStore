class RemovePictureFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :picture, :string
  end
end
