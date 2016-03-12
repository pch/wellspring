module Wellspring
  class BasePresenter
    def initialize(object, template)
      @object = object
      @template = template
    end

    private

    def self.presents(name)
      define_method(name) do
        @object
      end
    end

    def h
      @template
    end

    def method_missing(*args, &block)
      # this is probably too hacky
      if @object.respond_to?(args.first)
        @object.send(*args, &block)
      else
        @template.send(*args, &block)
      end
    end
  end
end
