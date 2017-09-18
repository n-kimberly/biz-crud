module UsersHelper
  # Checks whether there are any posts and/or comments to show
  def user_has_posts?(user)
    user.posts.count > 0
  end
  def user_has_comments?(user)
    user.comments.count > 0
  end
  def user_has_favorites?(user)
    user.favorites.count > 0
  end
end
