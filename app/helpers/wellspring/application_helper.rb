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
  end
end
