require 'test_helper'

module Wellspring
  class DashboardControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
      session[:logged_in] = true
    end

    test "should get index" do
      get :index
      assert_response :success
    end

  end
end
