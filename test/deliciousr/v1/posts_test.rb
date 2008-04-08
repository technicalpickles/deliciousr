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
          @api_call = Recent.new(stub)
        end
          
      end
      
    end
  end
end
