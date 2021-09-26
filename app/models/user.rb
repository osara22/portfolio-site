class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :blog_favorites, dependent: :destroy
  has_many :question_favorites, dependent: :destroy

  validates :introduction, length: { maximum: 255 }
  validates :name, length: { in: 2..20 }
  validates :name, :email, presence: true

  attachment :user_image
end
