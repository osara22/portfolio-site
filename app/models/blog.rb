class Blog < ApplicationRecord
  attachment :top_image
  attachment :body_image

  validates :title, :body, presence: true
end
