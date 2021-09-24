class AddTweetCodeToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :tweet_code, :text
  end
end
