require File.dirname(__FILE__) + "/../../test_helper.rb"

module Deliciousr
  module V1
    class ApiCallTest < Test::Unit::TestCase
      context "An api call instance" do
        setup do
          @user = stub()
          @api_call = ApiCall.new(@user)
          def @api_call.parse(xml)
          end
        end
        
        context "#call" do
          should "invoke do_response" do
            xml = stub()
            @api_call.expects(:do_request)
            @api_call.expects(:as_xml).returns(xml)
            @api_call.expects(:parse).with(xml)
            
            @api_call.call
          end
        end
        
        should '#action should default to lowercase version of class name' do
          assert {:apicall == @api_call.action}
        end
        
        should_eventually 'raise an exception when invoking #parse(xml)' do
          assert_raise {
            @api_call.parse(stub)
          }
        end
      end
      
      def self.should_build_query_string(expected, parameters)
        should "be #{expected} for #{parameters.inspect}" do
          query = ApiCall.build_query_string(parameters)
          assert {expected == query}
        end
      end
      
      context 'ApiCall#build_query_string' do
        should_build_query_string nil, nil
        should_build_query_string nil, {}
        should_build_query_string 'a=1&b=2', {:a => 1, :b => 2}
        should_build_query_string 'b=2&c=3', {:c => 3, :b => 2} 
      end
      
      context 'ApiCall#action' do
        setup do
          @api_call = ApiCall.new(stub)
          @api_call.class.action 'foo'
        end
        
        should 'define #action with specified string' do
          assert {:foo == @api_call.action}
        end
      end
      
      context 'ApiCall#optional' do
        setup do
          @api_call = ApiCall.new(stub)
        end
        
        context 'with :foo, :bar' do
          setup do
            @optional = [:foo, :bar]
            @api_call.class.optional *@optional
          end
        
          should 'define #optional_parameters' do
            assert {@api_call.respond_to?(:optional_parameters)}
          end
        
          should 'define #optional_parmeters to return [:foo, :bar]' do
            assert {@api_call.optional_parameters == @optional}
          end
        end
        
        context 'with :none' do
          setup do
            @api_call.class.optional :none
          end
          
          should 'define #optional_parameters' do
            assert {@api_call.respond_to?(:optional_parameters)}
          end
        
          should 'define #optional_parmeters to return []' do
            assert {@api_call.optional_parameters == []}
          end
        end
      end
      
      context 'ApiCall#required' do
        setup do
          @api_call = ApiCall.new(stub)
        end
        
        context 'with :foo, :bar' do
          setup do
            @required = [:foo, :bar]
            @api_call.class.required *@required
          end
        
          should 'define #required_parameters' do
            assert {@api_call.respond_to?(:required_parameters)}
          end
        
          should 'define #required_parameters to return [:foo, :bar]' do
            assert {@api_call.required_parameters == @required}
          end
        end
        
        context 'with :none' do
          setup do
            @api_call.class.required :none
          end
          
          should 'define #required_parameters' do
            assert {@api_call.respond_to?(:required_parameters)}
          end
        
          should 'define #required_parameters to return []' do
            assert {@api_call.required_parameters == []}
          end
        end
      end
    end
  end
end
