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
    end
  end
end
