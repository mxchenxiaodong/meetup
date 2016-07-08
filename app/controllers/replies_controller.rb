class RepliesController < ApplicationController
  before_action :set_topic

  def create
    @reply = Reply.new(reply_params)
    @reply.user_id = current_user.id
    @reply.topic_id = @topic.id

    if @reply.save
      redirect_to "/topics/#{@topic.id}"
    else
      flash[:danger] = @reply.errors.full_messages
      redirect_to "/topics/#{@topic.id}"
    end
  end

  protected

  def reply_params
    params.require(:reply).permit(:content)
  end

  def set_topic
    @topic = Topic.find_by_id(params[:topic_id])
  end
end