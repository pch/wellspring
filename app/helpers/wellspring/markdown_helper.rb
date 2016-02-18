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
      text.gsub(/-- photoset --(.+)-- \/photoset --/m) do |s|
        buffer = '<div class="photoset">'
        content = $1.gsub("\r", "").strip.split("\n\n")
        content.each do |row|
          images = row.split("\n").reject { |i| i.strip.blank? }
          images.each do |image|
            buffer += image.gsub(/\!\[([^\]]?)\]\(([^)]+)\)/, '<figure class="photo-col-' + images.size.to_s + '"><a href="\2"><img src="\2" alt="1"></a></figure>')
          end
        end
        p buffer

        buffer + '</div>'

      end
    end
  end
end
