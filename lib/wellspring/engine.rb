module Wellspring
  class Engine < ::Rails::Engine
    isolate_namespace Wellspring

    require 'jquery-rails'
    require 'dropzonejs-rails'
    require 'rdiscount'
    require 'carrierwave'
    require 'thumbor_rails'

    require 'bourbon'
  end
end
