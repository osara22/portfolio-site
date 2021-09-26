class Blog < ApplicationRecord
  attachment :top_image
  attachment :body_image
  has_many :blog_comments, dependent: :destroy
  has_many :blog_favorites, dependent: :destroy

  validates :title, :body, :top_image, presence: true
  validates :title, :video_url, :twitter_url, length: { maximum: 255 }

  # 閲覧数カウント機能の追加
  is_impressionable counter_cache: true

  # タグ機能の追加
  acts_as_taggable

  # お気に入り登録しているか
  def favorited_by?(user)
    blog_favorites.where(user_id: user.id).exists?
  end

  # youtubeのURLのIDを抽出する
  def split_id_from_youtube_url
    url = video_url.gsub('=', '/')
    url.split('/').last
  end
end
