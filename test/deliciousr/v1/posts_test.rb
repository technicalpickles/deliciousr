require File.dirname(__FILE__) + "/../../test_helper.rb"

module Deliciousr
  module V1
    class PostsTest < Test::Unit::TestCase
      context 'LastUpdated' do
        setup do
          @api_call = Deliciousr::V1::Posts::LastUpdated.new(stub)
          @expected_date = example_last_updated_posts_date
        end
        
        method_should_be :posts
        action_should_be :update        
        should_have_required_parameters :none
        should_have_optional_parameters :none
        should_build_request_path '/v1/posts/update'
        
        should 'parse response as a date' do
          root = build_root_for(example_last_updated_posts_response)
          actual_date = @api_call.parse(root)
          
          assert {@expected_date == actual_date}
        end
        

      end
      
      context 'Recent' do
        setup do
          @api_call = Deliciousr::V1::Posts::Recent.new(stub)
          @root = build_root_for(example_recent_posts_response)
        end
        
        method_should_be :posts
        action_should_be :recent
        should_have_required_parameters :none
        should_have_optional_parameters :tag, :count
        
        context 'without any optional parameters' do      
          should 'parse 2 posts' do
            posts = @api_call.parse(@root)
          
            assert {posts.size == 2}
          end
        
          context 'first parsed post' do
            setup do
              @post = @api_call.parse(@root).first
            end
          
            should 'have href be http://www.weather.com' do
              assert {@post.href == 'http://www.weather.com/'}
            end
          
            should 'have description be weather.com' do
              assert {@post.description == 'weather.com'}
            end
          
            should 'have weather and reference tags' do
              assert {@post.tags.size == 2}
              assert {@post.tags.first.name == 'weather'}
              assert {@post.tags.last.name == 'reference'}
            end
          
            should_eventually 'have date be 2005-11-29T20:30:47Z' do
              assert {@post.date == DateTime.parse('2005-11-29T20:30:47Z')}
            end
          end
        end
      end
    end
  end
end
