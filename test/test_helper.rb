require 'test/unit'
require 'rubygems'
require 'context'
require 'matchy'
require 'pending'
require 'fake_web'

FakeWeb.allow_net_connect = false

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib') )
require 'deliciousr'

class Test::Unit::TestCase
  
  def stubbing_http_response_with(xml)
    response = stub(:body => xml, :value => nil)
    Net::HTTP.any_instance.stubs(:request).returns(response)

    yield
  end

  def stub_user()
    stub(:username => 'foo', :password => 'bar')
  end

  def fixture_path(fixture)
    File.join(File.dirname(__FILE__), 'fixtures', fixture)
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
end
