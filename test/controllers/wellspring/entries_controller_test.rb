require 'test_helper'

module Wellspring
  class EntriesControllerTest < ActionController::TestCase
    setup do
      @entry = wellspring_entries(:sample)
      @routes = Engine.routes

      session[:logged_in] = true
    end

    test "should redirect to sign_in_url if not logged in" do
      session[:logged_in] = false

      get :index, content_class: 'BlogPost'
      assert_redirected_to '/login'
    end

    test "should get index" do
      get :index, content_class: 'BlogPost'
      assert_response :success
      assert_not_nil assigns(:entries)
    end

    test "should get new" do
      get :new, content_class: 'BlogPost'
      assert_response :success
    end

    test "should create entry" do
      assert_difference('BlogPost.count') do
        post :create, content_class: 'BlogPost', entry: { body: 'hello', type: 'BlogPost', title: @entry.title }
      end

      assert_redirected_to entry_path(assigns(:entry), content_class: 'blog_posts')
    end

    test "should show entry" do
      get :show, id: @entry, content_class: 'BlogPost'
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @entry, content_class: 'BlogPost'
      assert_response :success
    end

    test "should update entry" do
      patch :update, content_class: 'BlogPost', id: @entry, entry: { body: 'updated body', title: @entry.title }
      assert_redirected_to entry_path(assigns(:entry), content_class: 'blog_posts')
    end

    test "should destroy entry" do
      assert_difference('Entry.count', -1) do
        delete :destroy, content_class: 'BlogPost', id: @entry
      end

      assert_redirected_to entries_path(content_class: 'blog_posts')
    end
  end
end
