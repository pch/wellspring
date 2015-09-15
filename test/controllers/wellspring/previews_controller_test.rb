require 'test_helper'

module Wellspring
  class PreviewsControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
      session[:logged_in] = true
    end

    test "should get show" do
      get :show
      assert_response :success
    end

  end
end
