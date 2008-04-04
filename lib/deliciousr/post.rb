module Deliciousr
  class Post
    def self.attrs
      [:href, :description, :extended, :hash, :date, :tags]
    end
    attr_accessor *self.attrs
    
    def initialize(params={})
      params.each_pair do |key, value|
        send "#{key}=", value
      end
    end
    
    def self.parse(node)

    end
  end
end