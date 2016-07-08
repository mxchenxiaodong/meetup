module ApplicationHelper

  def notice_message
    flash_messages = []

    flash.each do |type, message|
      type = :success if type.to_sym == :notice
      type = :danger if type.to_sym == :alert
      text = content_tag(:div, link_to('x', '#', :class => 'close', 'data-dismiss' => 'alert') + Array(message).first, class: "alert alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end

  def time_tag(time)
    time.strftime("%Y-%m-%d %H:%M:%S")
  end

  def full_title(page_title = '')
    base_title = "Meetup"
    return base_title if page_title.empty?

    page_title + " | " + base_title
  end

end
