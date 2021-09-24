class RemoveUserIdFromBlogComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :blog_comments, :user_id, :integer
  end
end
