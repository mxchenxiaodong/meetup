module Meetup
  class Markdown
    def self.render(text)
      return self.instance.render(text).html_safe
    end

    def self.instance
      options = {
        filter_html: true,
        hard_wrap: true,
        link_attributes: { rel: 'nofollow', target: "_blank" },
        space_after_headers: true,
        fenced_code_blocks: true
      }

      @markdown ||= Redcarpet::Markdown.new(Meetup::Render.new, options)
    end
  end

  class Render < Redcarpet::Render::HTML
    def initialize(extensions={})
      extensions = {
        autolink: true,
        superscript: true,
        disable_indented_code_blocks: true
      }
      super(extensions.merge(extensions))
    end
  end
end

