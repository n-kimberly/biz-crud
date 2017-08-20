class PostsController < ApplicationController
  def index
    # Declare instance variable @posts and assign to Post object
    # All is an activerecord method.
    @posts = Post.all
  end

  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    if @post.save
      flash[:notice] = "Post has been published."
      redirect_to  @post
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    # Create new instance variable and assign to empty post via Post.new.
    @post = Post.new
  end

  def edit
  end

end
