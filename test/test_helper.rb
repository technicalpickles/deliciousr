require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha'
require 'assert2'

require File.dirname(__FILE__) + '/../lib/deliciousr'

require 'redgreen'
require 'file_fixture/test_unit'
FileFixture::FIXTURE_DIR = File.join(File.dirname(__FILE__), "fixtures")

class Test::Unit::TestCase
  
  def stubbing_http_response_with(xml)
    response = stub(:body => xml, :value => nil)
    Net::HTTP.any_instance.stubs(:request).returns(response)

    yield
  end

  def stub_user()
    stub(:username => 'foo', :password => 'bar')
  end

  def example_get_tags_response()
    file_fixture('get_tags.xml')
  end

  def example_rename_tags_response()
    file_fixture('rename_tags.xml')
  end

  def example_last_updated_posts_response()
    file_fixture('last_updated_posts.xml')
  end

  def example_last_updated_posts_date
    DateTime.parse('2005-11-29T20:31:52Z')
  end

  def example_get_posts_response()
    file_fixture('get_posts.xml')
  end

  def example_recent_posts_response()
    file_fixture('recent_posts.xml')
  end
  
  def self.action_should_be(action)
    action = action.to_sym
    should "have action be #{action.inspect}" do
      assert {action == @api_call.action}
    end
  end
  
  def self.method_should_be(method)
    method = method.to_sym
    should "have method be #{method.inspect}" do
      assert {method == @api_call.method}
    end
  end
  
  def self.should_build_request_path(path)
    should "build request path of #{path}" do
      assert {path == @api_call.build_request_path}
    end
  end
  
  def self.should_require_parameters(*parameters)
    should_have_required_parameters(*parameters)
  end
  
  def self.should_have_required_parameters(*parameters)
    if parameters.first == :none
      should 'not have any required parameters' do
        assert {@api_call.required_parameters.empty?}
      end
    else
      should "require #{parameters}" do
        parameters.each do |parameter|
          assert {@api_call.required_parameters.include?(parameter)}
        end
      end
    end
  end

  def self.should_have_optional_parameters(*parameters)
    if parameters.first == :none
      should 'not have any optional parameters' do
        assert {@api_call.optional_parameters.empty?}
      end
    else
      should "have optional parameters #{parameters.inspect}" do
        parameters.each do |parameter|
          assert {@api_call.optional_parameters.include?(parameter)}
        end
      end
    end
  end

  def build_root_for(xml)
    REXML::Document.new(xml).root
  end
end