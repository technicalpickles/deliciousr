require File.dirname(__FILE__) + "/../../test_helper.rb"

module Deliciousr
  module V1
    module Tags
      class GetTagsCallTest < Test::Unit::TestCase
        def setup
          @user = stub()
          
          @api_call = GetTagsCall.new(@user)
        end
        
        should 'have method should be :tags' do
          assert {@api_call.method == :tags}
        end
        
        action_should_be :get
        
        should 'parse response into an array of tags' do
          root = build_root_for(example_get_tags_response)
          response = @api_call.parse(root)
          
          assert {6 == response.size}
          
          activedesktop = response[0]
          
          assert {'activedesktop' == activedesktop.name}
          assert {1 == activedesktop.count}
        end
        
        should 'not require any parameters' do
          assert {0 == @api_call.required_parameters.size}
        end
        
        should 'associate found tags with current user' do
          root = build_root_for(example_get_tags_response)
          tags = @api_call.parse(root)
          tags.each do |tag|
            assert {@user === tag.user}
          end
        end
        
        should_build_request_path '/v1/tags/get'
      end
      
      class RenameTagsCallTest < Test::Unit::TestCase
        def setup
          @api_call = RenameTagsCall.new(stub)
        end
        
        action_should_be :rename
        
        should 'require old and new parameters' do
          assert {@api_call.required_parameters.include?(:old)}
          assert {@api_call.required_parameters.include?(:new)}
        end
        
        should 'not have any optional parameters' do
          assert {@api_call.optional_parameters.empty?}
        end
        
        should 'parse response as a boolean' do
          root = build_root_for(example_rename_tags_response)
          response = @api_call.parse(root)
          
          assert {response == true}
        end
        
        should_build_request_path '/v1/tags/rename'
      end
    end
  end
end