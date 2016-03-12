module Wellspring
  class EntryPresenter < BasePresenter
    presents :entry

    MARKDOWN_OPTIONS = {
      filter_html: false,
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      tables: true,
      footnotes: true
    }.freeze

    def body_markdown
      text = parse_custom_markdown(@object.body.to_s)

      renderer = ::Redcarpet::Render::HTML.new(hard_wrap: false, filter_html: false)
      ::Redcarpet::Markdown.new(renderer, MARKDOWN_OPTIONS).render(text.to_s).html_safe
    end

    def photoset_item_html(src:, alt:)
      img = images_hash[src.split('/').last]

      %Q{
        <figure class="photoset-item">
          <a href="#{src}"><img src="#{src}" alt="#{alt}" data-ratio="#{img.ratio}" /></a>
          <figcaption>#{alt}</figcaption>
        </figure>
      }
    end

    def single_image_html(src:, alt:)
      %Q{
        <figure>
          <a href="#{src}"><img src="#{src}" alt="#{alt}" /></a>
          <figcaption>#{alt}</figcaption>
        </figure>
      }
    end

    private

    def parse_custom_markdown(text)
      Wellspring::CustomMarkdownParser.new(self).parse(text)
    end

    def images_hash
      @images_hash ||= @object.images.each_with_object({}) do |img, hash|
        hash[img.image.file.filename] = img
      end
    end
  end
end
