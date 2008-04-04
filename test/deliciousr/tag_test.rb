require File.dirname(__FILE__) + "/../test_helper.rb"

module Deliciousr
  class TagTest < Test::Unit::TestCase
    context 'tag with name and count' do
      setup do
        @user = stub_user()
        @tag = Tag.new('foo', 3)
        @tag.user = @user
      end
    
      should 'have a name' do
        assert_equal 'foo', @tag.name
      end
    
      should 'have a count' do
        assert_equal 3, @tag.count
      end
      
      should 'be able to be renamed' do
        stubbing_http_response_with(example_rename_tags_response) do
          assert @tag.rename_all!('bar')
        end
      end
    end
  end
end