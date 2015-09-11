require 'test_helper'

module Wellspring
  class FooContent < Entry; end

  class EntryTest < ActiveSupport::TestCase
    test "content_attr" do
      assert_equal({}, FooContent.content_attributes)

      FooContent.content_attr(:foo_attr, :text)
      FooContent.content_attr(:bar_attr, :integer)

      assert_equal :text, FooContent.content_attributes[:foo_attr]
      assert_equal :integer, FooContent.content_attributes[:bar_attr]

      foo  = FooContent.new
      post = BlogPost.new

      assert foo.respond_to?(:foo_attr)
      assert !post.respond_to?(:foo_attr)

      foo.foo_attr = "Hello"

      assert_equal "Hello", foo.foo_attr
      assert_equal "Hello", foo.payload["foo_attr"]
    end
  end
end
