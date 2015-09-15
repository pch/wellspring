module Wellspring
  class Engine < ::Rails::Engine
    isolate_namespace Wellspring

    require 'jquery-rails'
    require 'font-awesome-rails'
    require 'redcarpet'
    require 'pygments'
  end
end
