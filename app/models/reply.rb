class Reply < ActiveRecord::Base

  validates :content, presence: true

  belongs_to :topic
  belongs_to :user

  before_save :fill_content_html

  def fill_content_html
    self.content_html = Meetup::Markdown.render(self.content)
  end

end
