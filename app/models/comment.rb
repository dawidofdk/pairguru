class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user, uniqueness: { scope: :movie, message: "has already commented on this movie" }
  validates :user, presence: true
  validates :movie, presence: true
  validates :content, presence: true
end
