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
    IMAGE_PATTERN = /\!\[([^\]]*)\]\(([^)]+)\)/

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
          images = items.map { |image| parse_image(image, :photoset_item_html) }

          PHOTOSET_ROW_HTML % { items: images.join("\n") }
        end

        PHOTOSET_HTML % { rows: "\n" + rows.join("\n") + "\n" }
      end
    end

    def parse_single_images(text)
      parse_image(text, :single_image_html)
    end

    private

    def parse_image(text, callback)
      text.gsub(IMAGE_PATTERN) do
        item = @presenter.send(callback, src: $2, alt: $1)
        item = item.gsub(/<figcaption>\s?<\/figcaption>/, '') # remove empty captions:
        item.gsub(/^\s+/, '') # remove indentation from the beginning of lines
      end
    end
  end
end
