class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user)
    # SHow list of favorited posts
    @favposts = @user.favposts.visible_to(current_user)
    # @favorites = @user.favorites.visible_to(current_user)
  end

  def create
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "Welcome to Business CRUD #{@user.name}!"
      create_session(@user)
      redirect_to root_path
    else
      flash[:error] = "There was an error creating your account. Please try again."
      render :new
    end
  end
end
