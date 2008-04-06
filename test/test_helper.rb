require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha'
require 'assert2'

require File.dirname(__FILE__) + '/../lib/deliciousr'

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
    <<-EOF
      <tags>
        <tag count="1" tag="activedesktop" />
        <tag count="1" tag="business" />
        <tag count="3" tag="radio" />
        <tag count="5" tag="xml" />
        <tag count="1" tag="xp" />
        <tag count="1" tag="xpi" />
      </tags>
    EOF
  end

  def example_rename_tags_response()
    %Q(<result>done</result>)
  end

  def example_last_updated_posts_response()
    %Q(<update time="2005-11-29T20:31:52Z" />)
  end

  def example_last_updated_posts_date
    DateTime.parse('2005-11-29T20:31:52Z')
  end

  def example_get_posts_response()
    <<-EOF
      <posts dt="2005-11-28" tag="webdev" user="user">
        <post href="http://www.howtocreate.co.uk/tutorials/texterise.php?dom=1" 
        description="JavaScript DOM reference" 
        extended="dom reference" 
        hash="c0238dc0c44f07daedd9a1fd9bbdeebd" 
        others="55" tag="dom javascript webdev" time="2005-11-28T05:26:09Z" />
      </posts>
    EOF
  end

  def example_recent_posts_response()
    <<-EOF
      <posts tag="" user="user">
        <post href="http://www.weather.com/" description="weather.com" 
        hash="6cfedbe75f413c56b6ce79e6fa102aba" tag="weather reference" 
        time="2005-11-29T20:30:47Z" />
        <post href="http://www.nytimes.com/" 
        description="The New York Times - Breaking News, World News & Multimedia" 
        extended="requires login" hash="ca1e6357399774951eed4628d69eb84b" 
        tag="news media" time="2005-11-29T20:30:05Z" />
      </posts>
    EOF
  end

  def build_root_for(xml)
    REXML::Document.new(xml).root
  end
end