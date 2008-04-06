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
    end
  end
end
