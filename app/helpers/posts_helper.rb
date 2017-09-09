module PostsHelper
  def user_is_authorized_for_update?(post)
    current_user && (current_user == post.user || current_user.admin? || current_user.mod?)
  end
  def user_is_authorized_for_destroy?(post)
    current_user && (current_user == post.user || current_user.admin?)
  end
end
