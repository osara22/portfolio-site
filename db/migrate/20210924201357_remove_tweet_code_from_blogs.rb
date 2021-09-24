class RemoveTweetCodeFromBlogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :blogs, :tweet_code, :text
    add_column :blogs, :twitter_url, :string
  end
end
