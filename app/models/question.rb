class Question < ApplicationRecord
  belongs_to :user
  has_many :answers

  validates :title, :body, presence: true

  attachment :image

  # 質問に答えたか
  def answed_by?(user)
    answers.where(user_id: user.id).exists?
  end
end
