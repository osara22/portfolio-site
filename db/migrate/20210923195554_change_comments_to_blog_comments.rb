class ChangeCommentsToBlogComments < ActiveRecord::Migration[5.2]
  def change
    rename_table :comments, :blog_comments
  end
end
