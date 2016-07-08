module TopicsHelper

  def topic_creator(topic)
    topic.user.try(:name)
  end

  def reply_creator(reply)
    reply.user.try(:name)
  end
end