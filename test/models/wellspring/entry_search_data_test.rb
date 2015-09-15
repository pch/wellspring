require 'test_helper'

module Wellspring
  class EntrySearchDataTest < ActiveSupport::TestCase
    setup do
      BlogPost.searchable_attributes(:title, :body)

      @post1 = BlogPost.create(title: "Hello World", body: "This is an example blog post about something")
      @post2 = BlogPost.create(title: "Hello Again", body: "Yet another example of full-text search")
    end

    test "index_entry_data" do
      assert_equal 2, @post1.search_data.size

      assert_no_difference('Wellspring::EntrySearchData.count') do
        @post1.update_attribute(:title, "Hello World!!!")

        assert_equal "Hello World!!!", @post1.search_data.find_by(attr_name: 'title').raw_data
      end
    end

    test "search" do
      assert_equal [@post1], BlogPost.search('hello world')
      assert_equal [@post1, @post2], BlogPost.search('hello')
      assert_equal [@post1, @post2], BlogPost.search('example')
      assert_equal [@post2], BlogPost.search('full-text')
      assert_equal [@post1], BlogPost.search('blog posts')
    end
  end
end
