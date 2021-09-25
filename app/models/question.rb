class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :question_favorites, dependent: :destroy

  validates :title, :body, presence: true

  attachment :image

  # お気に入り登録しているか
  def favorited_by?(user)
    question_favorites.where(user_id: user.id).exists?
  end

  # 質問に答えたか
  def answed_by?(user)
    answers.where(user_id: user.id).exists?
  end
end
