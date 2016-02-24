module Wellspring
  module MarkdownHelper
    def markdown(text)
      renderer = ::Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: false)
      options = {
        filter_html: false,
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        tables: true,
        footnotes: true
      }

      text = parse_photosets(text.to_s)

      ::Redcarpet::Markdown.new(renderer, options).render(text.to_s).html_safe
    end

    def parse_photosets(text)
      Wellspring::PhotosetParser.new.parse(text)
    end
  end
end
