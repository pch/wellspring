module Wellspring
  module MarkdownHelper
    class HTMLwithPygments < ::Redcarpet::Render::HTML
      include ::Redcarpet::Render::SmartyPants

      def block_code(code, language)
        Pygments.highlight(code, lexer: language)
      end
    end

    def markdown(text)
      renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: false)
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
      ::Redcarpet::Markdown.new(renderer, options).render(text.to_s).html_safe
    end
  end
end
