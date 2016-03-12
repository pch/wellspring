module Wellspring
  class CustomMarkdownParser
    def initialize(presenter)
      @presenter = presenter
    end

    # Matches photoset enclosing tags:
    # <!-- photoset --> ... <!-- /photoset -->
    PHOTOSET_PATTERN = /<!--\s?photoset\s?-->(.*?)<!--\s?\/photoset\s*-->/m

    # Matches a single image in the Markdown format:
    # ![alt text](/path/to/image.jpg)
    IMAGE_PATTERN = /\!\[([^\]]*)\]\(([^)]+)\)(\{([^{]+)\})?/

    PHOTOSET_HTML     = '<div class="photoset">%{rows}</div>'
    PHOTOSET_ROW_HTML = '<div class="photoset-row">%{items}</div>'

    def parse(text)
      text = parse_photosets(text)
      text = parse_single_images(text)

      text
    end

    def parse_photosets(text)
      text.gsub(PHOTOSET_PATTERN) do |s|
        # Photoset row is a a set of images separated by 2 new line characters
        rows = $1.gsub("\r", "").strip.split("\n\n").map do |row|
          # Each line in row is considered an "item" (image)
          items  = row.split("\n").reject { |i| i.strip.blank? }
          images = items.map { |image| parse_image(image, :photoset_item) }

          PHOTOSET_ROW_HTML % { items: images.join("\n") }
        end

        PHOTOSET_HTML % { rows: "\n" + rows.join("\n") + "\n" }
      end
    end

    def parse_single_images(text)
      parse_image(text, :single_image)
    end

    private

    def parse_image(text, callback)
      text.gsub(IMAGE_PATTERN) do
        attrs = parse_special_attributes($4)

        item = @presenter.send(callback, src: $2, alt: $1, attrs: attrs)
        item = item.gsub(/<figcaption>\s?<\/figcaption>/, '') # remove empty captions:
        item.gsub(/^\s+/, '') # remove indentation from the beginning of lines
      end
    end

    # Parses additional attributes placed within brackets:
    #
    # ![](/foo.jpg){.regular #hero lang=fr}
    # ![](/bar.jpg){.big #the-site data-behavior=lightbox}
    #
    # Note: works with images only.
    def parse_special_attributes(raw_attrs)
      return {} if raw_attrs.blank?
      items = raw_attrs.split(/\s+/)

      id      = items.select { |i| i =~ /^#.+/ }.first.gsub('#', '')
      classes = items.select { |i| i =~ /^\..+/ }.map { |c| c.gsub('.', '') }
      attrs   = Hash[items.select { |i| i.include?('=') }.map { |i| i.split('=') }]

      attrs.merge({
        'id' => id,
        'class' => classes.join(' ')
      })
    end
  end
end
