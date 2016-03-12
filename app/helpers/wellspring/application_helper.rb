module Wellspring
  module ApplicationHelper
    def title(title = nil)
      if title
        content_for(:title) { title }
      else
        content_for(:title)
      end
    end

    def body_class(options = {})
      controller_name = controller.controller_path.gsub('/','-')
      basic_body_class = "#{controller_name} #{controller_name}-#{controller.action_name}"

      if content_for?(:body_class)
        [basic_body_class, content_for(:body_class)].join(' ')
      else
        basic_body_class
      end
    end

    def present(object, klass = nil)
      begin
        klass ||= "#{object.class}Presenter".constantize
      rescue NameError
        klass = "#{object.class.superclass}Presenter".constantize
      end
      presenter = klass.new(object, self)
      yield presenter if block_given?
      presenter
    end
  end
end
