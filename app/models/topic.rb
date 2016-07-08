class Topic < ActiveRecord::Base

  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true

  has_many :replies
  belongs_to :user

  before_save :fill_content_html

  def fill_content_html
    self.content_html = Meetup::Markdown.render(self.content)
  end
end
