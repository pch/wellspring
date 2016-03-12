module Wellspring
  class EntryPresenter < BasePresenter
    presents :entry

    DEFAULT_THUMBNAIL_WIDTH = 500

    def body_markdown
      text = parse_custom_markdown(@object.body.to_s)
      RDiscount.new(text, :smart, :footnotes).to_html.html_safe
    end

    def photoset_item(src:, alt:, attrs:)
      img = images_hash[src.split('/').last]
      attrs["class"] = "photoset-item " + attrs["class"].to_s

      photoset_item_html(img, src, alt, attrs, image_attrs(img))
    end

    def photoset_item_html(img, src, alt, attrs, image_attrs)
      content_tag(:figure, attrs) do
        concat image_tag(thumbnail_url(src, width: DEFAULT_THUMBNAIL_WIDTH), { alt: alt }.merge(image_attrs))
        concat content_tag(:figcaption, alt)
      end
    end

    def single_image_html(src:, alt:, attrs:)
      content_tag(:figure, attrs) do
        concat image_tag(thumbnail_url(src, width: DEFAULT_THUMBNAIL_WIDTH), alt: alt)
        concat content_tag(:figcaption, alt)
      end
    end

    def thumbnail_url(image_url, attrs)
      thumbor_url(request.protocol + request.host + image_url, attrs)
    end

    def image_attrs(img)
      return {} unless img

      { data: { width: img.width, height: img.height, ratio: img.ratio } }
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
