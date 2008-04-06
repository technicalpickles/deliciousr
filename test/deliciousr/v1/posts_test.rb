require File.dirname(__FILE__) + "/../../test_helper.rb"

module Deliciousr
  module V1
    module Posts
      class LastUpdatedTest < Test::Unit::TestCase
        def setup
          @user = stub_user()
          @api_call = LastUpdated.new(@user)
          @expected_date = example_last_updated_posts_date
        end
        
        should 'have method be :posts' do
          assert {:posts == @api_call.method}
        end
        
        should 'have action be :update' do
          assert {:update == @api_call.action}
        end
        
        should 'parse response as a date' do
          root = build_root_for(example_last_updated_posts_response)
          actual_date = @api_call.parse(root)
          
          assert {@expected_date == actual_date}
        end
        
        should 'not have any required parameters' do
          assert {0 == @api_call.required_parameters.size}
        end
        
        should 'request /v1/posts/update' do
          assert {'/v1/posts/update' == @api_call.build_request_path}
        end
      end
    end
  end
end
