class ChangeColumnTitleInPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :title, :name
  end
end
