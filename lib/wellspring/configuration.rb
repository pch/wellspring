module Wellspring
  class Configuration
    attr_accessor :content_classes

    def initialize
      @content_classes = [].freeze
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
