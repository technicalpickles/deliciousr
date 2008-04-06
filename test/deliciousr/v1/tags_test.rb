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
        
        should 'have action be :get' do
          assert {@api_call.action == :get}
        end
        
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
        
        should 'build request path of /v1/tags/get' do
          assert {'/v1/tags/get' == @api_call.build_request_path}
        end
      end
      
      class RenameTagsCallTest < Test::Unit::TestCase
        def setup
          @user = mock()
          
          @api_call = RenameTagsCall.new(@user)
        end
        
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
          
          assert {response}
        end
        
        should 'build request path of /v1/tags/get' do
          assert {'/v1/tags/rename' == @api_call.build_request_path}
        end
      end
    end
  end
end