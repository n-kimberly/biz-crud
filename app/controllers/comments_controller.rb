class CommentsController < ApplicationController

  # Ensure that guests are not permitted to create or destroy comments.
  before_action :require_sign_in

  # Allow only admin and author users to destroy comments
  before_action :authorize_user, only: [:destroy]

  def create
    # Find the current post via post id
    @post = Post.find(params[:post_id])
    # Create new comment using comment_params.
    comment = @post.comments.new(comment_params)
    # Match the authorship with the current user
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment saved successfully."
      redirect_to [@post.topic, @post]
    else
      flash[:alert] = "Comment failed to save."
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    # Find the current post via post id
    @post = Post.find(params[:post_id])
    # Identify the current comment via id
    comment = @post.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted."
      redirect_to [@post.topic, @post]
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_to [@post.topic, @post]
    end
  end

  private
  def comment_params
    # Passes all of the information needed to create comment.
    params.require(:comment).permit(:body)
  end
  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete this comment."
    end
  end
end
