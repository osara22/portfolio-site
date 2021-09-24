class AddNameToBlogComments < ActiveRecord::Migration[5.2]
  def change
    add_column :blog_comments, :name, :string
  end
end
