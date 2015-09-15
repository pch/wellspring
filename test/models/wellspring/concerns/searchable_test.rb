require 'test_helper'

module Wellspring
  class FooSearchableContent < Entry
    content_attr :body, :text
    content_attr :url, :string
  end

  class EntryTest < ActiveSupport::TestCase
    test "searchable_attributes" do
      FooSearchableContent.searchable_attributes(:foo_attr, :bar_attr)
      assert_equal [:foo_attr, :bar_attr], FooSearchableContent.searchable_attributes
    end

    test "search_attributes" do
      FooSearchableContent.searchable_attributes(:title, :body)

      foo = FooSearchableContent.new(title: "Hello", body: "World")
      assert_equal({ title: "Hello", body: "World"}, foo.search_attributes)
    end

    test "update_search_index" do
      FooSearchableContent.searchable_attributes(:title, :body)

      assert_difference('Wellspring::EntrySearchData.count', 2) do
        FooSearchableContent.create(title: "Hello", body: "World")
      end
    end
  end
end
