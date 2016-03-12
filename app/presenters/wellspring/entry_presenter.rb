module Wellspring
  class EntryPresenter < BasePresenter
    presents :entry

    def body_markdown
      text = parse_custom_markdown(@object.body.to_s)
      RDiscount.new(text, :smart, :footnotes).to_html.html_safe
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
