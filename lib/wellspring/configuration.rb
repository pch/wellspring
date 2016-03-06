module Wellspring
  class Configuration
    attr_accessor :content_classes

    def initialize
      @content_classes = [].freeze
      @photoset_item_html = Proc.new { raise "No photoset item html provided!" }
    end

    def photoset_item_html(&block)
      @photoset_item_html = block if block
      @photoset_item_html
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
