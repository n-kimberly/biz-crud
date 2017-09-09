module TopicsHelper
  def user_is_authorized_for_topics_update?
     current_user && (current_user.admin? || current_user.mod?)
  end
  def user_is_authorized_for_topics_creation_destroy?
     current_user && current_user.admin?
  end
end
