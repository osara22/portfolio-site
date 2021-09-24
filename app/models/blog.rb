class Blog < ApplicationRecord
  attachment :top_image
  attachment :body_image
  has_many :blog_comments, dependent: :destroy

  validates :title, :body, presence: true

  # タグ機能の追加
  acts_as_taggable

  # youtubeのURLのIDを抽出する
  def split_id_from_youtube_url
    url = video_url.gsub("=","/")
    url.split('/').last
  end
end
