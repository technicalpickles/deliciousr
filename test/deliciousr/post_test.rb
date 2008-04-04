require File.dirname(__FILE__) + "/../test_helper.rb"

module Deliciousr
  class PostTest < Test::Unit::TestCase
    def new_params
      {
        :href => 'http://slashdot.org',
        :description => 'slashdot',
        :extended => 'blarg',
        :hash => 'xyzxyasydadsf',
        :date => date
      }
    end
    
    def date
      @@date ||= DateTime.new
    end
    
    context 'initializing a post' do
      should 'take a hash of parameters' do
        post = Post.new new_params
      end
    end
    
    context 'a post created with a hash' do
      setup do
        @post = Post.new new_params
      end
      
      should 'have a href' do
        assert_equal new_params[:href], @post.href
      end
      
      should 'have a description' do
        assert_equal new_params[:description], @post.description
      end
      
      should 'have an extended description' do
        assert_equal new_params[:extended], @post.extended
      end
      
      should 'have an hash' do
        assert_equal new_params[:hash], @post.hash
      end
      should 'have a date' do
        assert_equal new_params[:date], @post.date
      end
    end
    
    context 'parsing a post from rexml' do
      setup do
        
      end
    end
  end
end