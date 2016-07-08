class TopicsController < ApplicationController

  def new
  end

  def index
    @total_count = Topic.count
    @topics = Topic.includes(:user).order("created_at desc").page(page).per(10)
  end

  def show
    @topic = Topic.find_by_id(params[:id])
    @replies = @topic.replies.includes(:user)
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id

    if @topic.save
      redirect_to topics_path
    else
      flash.now[:danger] = @topic.errors.full_messages
      render :new
    end
  end

  protected

  def topic_params
    params.require(:topic).permit(:title, :content)
  end

  def page
    params[:page] || 1
  end

end
