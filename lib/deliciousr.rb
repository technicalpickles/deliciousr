%w(v1 user tag post).each do |f|
  require File.dirname(__FILE__) + "/deliciousr/#{f}"
end

module Deliciousr
  VERSION = '1.0.0'
end