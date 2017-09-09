class TopicsController < ApplicationController

  # If you want to do anything aside from render, you need to sign in.
  before_action :require_sign_in, except: [:index, :show]
  # If you want to update, you must be a signed in as a mod or admin.
  before_action :authorize_update, only: [:edit, :update]
  # If you want to create or destroy, you must be signed in as an admin.
  before_action :authorize_creation_destruction, only: [:new, :create, :destroy]

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash.now[:alert] = "Error creating topic. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "topic was updated."
      redirect_to @topic
    else
      flash.now[:alert] = "There was an error saving the topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the topic."
      render :show
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end

  def authorize_update
    unless current_user.mod? || current_user.admin?
      flash[:alert] = "You must be a moderator or admin to do that."
      redirect_to topics_path
    end
  end

  def authorize_creation_destruction
    unless current_user.admin?
      flash[:alert] = "You must be a moderator or admin to do that."
      redirect_to topics_path
    end
  end

end
