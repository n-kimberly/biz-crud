class PostsController < ApplicationController
  def index
    # Declare instance variable @posts and assign to Post object
    # All is an activerecord method.
    @posts = Post.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
