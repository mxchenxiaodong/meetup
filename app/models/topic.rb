class Topic < ActiveRecord::Base

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true

  has_many :replies
  belongs_to :user

  before_save :fill_content_html

  def fill_content_html
    self.content_html = Meetup::Markdown.render(self.content)
  end


  def Topic.update_content_sleep
    topic = Topic.first
    # 已经是悲观锁
    topic.with_lock do
      topic.content = SecureRandom.base64(64)
      sleep 10
      topic.save!
    end
  end

  def Topic.update_content
    topic = Topic.first
    # 已经是悲观锁
    topic.with_lock do
      topic.content = SecureRandom.base64(64)
      topic.save!
    end
  end

  def update_content(content)
    retry_times = 3

    begin
      self.update_content = content
      self.save!
    rescue ActiveRecord::StaleObjectError => e # 如果事务提交失败，那么 Rails 会抛一个 ActiveRecord::StaleObjectError 的异常。
      # 重试
      retry_times -= 1
      if retry_times > 0
        retry
      else
        raise e
      end
    rescue Exception => e
      raise e
    end
  end

end
