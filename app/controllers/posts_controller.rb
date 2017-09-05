class PostsController < ApplicationController

  # If you want to do anything aside from render, you need to sign in.
  before_action :require_sign_in, except: [:index, :show]
  # If you want to update, you must be a the author, mod or admin.
  before_action :authorize_update, only: [:edit, :update]
  # If you want to create or destroy, you must be the author or admin.
  before_action :authorize_destruction, only: :destroy

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post has been published."
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was updated."
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "#{@post.title} was deleted successfully."
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_update
    post = Post.find(params[:id])
    unless current_user == post.user || current_user.mod? || current_user.admin?
      flash[:alert] = "If you want to update, you must be a the author, mod or admin."
      redirect_to [post.topic, post]
    end
  end

  def authorize_destruction
    post = Post.find(params[:id])
    unless current_user == post.user || current_user.admin?
      flash[:alert] = "If you want to  destroy, you must be the author or admin."
      redirect_to [post.topic, post]
    end
  end

end
