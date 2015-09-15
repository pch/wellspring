require_dependency "wellspring/application_controller"

module Wellspring
  class PreviewsController < ApplicationController
    def show
      render layout: false
    end
  end
end
