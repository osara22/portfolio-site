class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :body
      t.string :top_image_id
      t.string :body_image_id
      t.string :video_url

      t.timestamps
    end
  end
end
