%w(api_call tags posts).each do |f|
  require File.dirname(__FILE__) + "/v1/#{f}"
end