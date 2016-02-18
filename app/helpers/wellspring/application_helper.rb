module Wellspring
  module ApplicationHelper
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
