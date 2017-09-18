class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :post

  scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }
  
end
