module Wellspring
  class Configuration
    attr_accessor :content_classes

    def initialize
      @content_classes = [].freeze
      @current_user_lookup = Proc.new { raise "No user lookup provided!" }
      @sign_in_url = Proc.new { raise "No sign in url provided!" }
      @photoset_item_html = Proc.new { raise "No photoset item html provided!" }
    end

    def current_user_lookup(&block)
      @current_user_lookup = block if block
      @current_user_lookup
    end

    def sign_in_url(&block)
      @sign_in_url = block if block
      @sign_in_url
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
