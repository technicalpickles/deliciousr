require File.dirname(__FILE__) + "/../test_helper.rb"

module Deliciousr
  class UserTest < Test::Unit::TestCase
    def setup
      @username = 'username'
      @password = 'sekrit'
      @user = Deliciousr::User.new(@username, @password)
    end
  
    should "have a username" do
      assert_equal @username, @user.username
    end
  
    should 'have a password' do
      assert_equal @password, @user.password
    end
    
    should 'have 6 tags' do
      stubbing_http_response_with(example_get_tags_response) do
        assert_equal 6, @user.tags.size
      end
    end
    
    should "have last updated on #{example_last_updated_posts_date}" do
      stubbing_http_response_with(example_last_updated_posts_response) do
        assert_equal example_last_updated_posts_date, @user.last_updated
      end
    end
  end
end