class Post < ApplicationRecord
  belongs_to :topic
  has_many :comments, dependent: :destroy

  validates :topic, presence: true
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true

end
