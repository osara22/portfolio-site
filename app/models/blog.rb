class Blog < ApplicationRecord
  attachment :top_image
  attachment :body_image

  validates :title, :body, presence: true

  # youtubeのURLのIDを抽出する
  def split_id_from_youtube_url
    url = video_url.gsub("=","/")
    url.split('/').last
  end
end
