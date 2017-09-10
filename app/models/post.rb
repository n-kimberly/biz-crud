class Post < ApplicationRecord

  belongs_to :topic
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  default_scope { order('rank DESC') }

  validates :topic, presence: true
  validates :user, presence: true
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true

  def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end

  def points
    self.votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end

end
