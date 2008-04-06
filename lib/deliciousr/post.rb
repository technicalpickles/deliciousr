module Deliciousr
  class Post
    def self.attrs
      [:href, :description, :extended, :hash, :date, :tags]
    end
    self.attrs.each {|name| attr_accessor name}
    
    def initialize(params={})
      params.each_pair do |key, value|
        send "#{key}=", value
      end
    end
    
    def self.parse(node)

    end
  end
end