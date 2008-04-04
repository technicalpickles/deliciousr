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
          assert_equal :posts, @api_call.method
        end
        
        should 'have action be :update' do
          assert_equal :update, @api_call.action
        end
        
        should 'parse response as a date' do
          root = build_root_for(example_last_updated_posts_response)
          actual_date = @api_call.parse(root)
          assert_equal @expected_date, actual_date
        end
        
        should 'not have any required parameters' do
          assert_equal 0, @api_call.required_parameters.size
        end
      end
      
      # class RecentTest < Test::Unit::TestCase
    end
  end
end
