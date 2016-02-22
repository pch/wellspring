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
      text.gsub(/<!--\s?photoset\s?-->(.*?)<!--\s?\/photoset\s*-->/m) do |s|
        buffer = '<div class="photoset">'
        content = $1.gsub("\r", "").strip.split("\n\n")
        content.each do |row|
          buffer << '<div class="photoset-row">'
          images = row.split("\n").reject { |i| i.strip.blank? }
          images.each do |image|
            buffer << image.gsub(/\!\[([^\]]*)\]\(([^)]+)\)/) do
              img = Wellspring::Image.find_by_image($2.split('/').last)
              next unless img

              item = '<figure class="photoset-item">'
              item << instance_exec($2, $1, img, &Wellspring.configuration.photoset_item_html)
              item << '</figure>'
            end
          end
          buffer << '</div>'
        end
        buffer << '</div>'
      end
    end
  end
end
