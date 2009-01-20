require File.join(File.dirname(__FILE__), '/test_helper.rb')

class DelicousrClientTest < Test::Unit::TestCase
  context "A client" do
    setup do
      @client = Deliciousr::Client.new('username', 'password')
    end


    context "finding all tags" do
      setup do

        FakeWeb.register_uri "https://api.del.icio.us/v1/tags/get", :response => fixture_path('get_tags.xml')
        @tags = @client.tags
      end

      test "size" do
        @tags.size.should == 465
      end

      test "first" do
        #@tags.first.name.should == ".net"
        @tags.first.count.should == 1
      end

    end
  end
end
