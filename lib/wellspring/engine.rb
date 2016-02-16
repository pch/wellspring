module Wellspring
  class Engine < ::Rails::Engine
    isolate_namespace Wellspring

    require 'jquery-rails'
    require 'dropzonejs-rails'
    require 'redcarpet'
    require 'carrierwave'

    require 'bourbon'
    require 'neat'
  end
end
