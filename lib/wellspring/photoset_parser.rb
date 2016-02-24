module Wellspring
  class PhotosetParser
    # Matches photoset enclosing tags:
    # <!-- photoset --> ... <!-- /photoset -->
    PHOTOSET_PATTERN = /<!--\s?photoset\s?-->(.*?)<!--\s?\/photoset\s*-->/m

    # Matches a single image in the Markdown format:
    # ![alt text](/path/to/image.jpg)
    IMAGE_PATTERN = /\!\[([^\]]*)\]\(([^)]+)\)/

    # TODO: refactor this monster
    def parse(text)
      text.gsub(PHOTOSET_PATTERN) do |s|
        buffer = '<div class="photoset">'
        rows = $1.gsub("\r", "").strip.split("\n\n")
        rows.each do |row|
          buffer << '<div class="photoset-row">'
          images = row.split("\n").reject { |i| i.strip.blank? }
          images.each do |image|
            buffer << image.gsub(IMAGE_PATTERN) do
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
