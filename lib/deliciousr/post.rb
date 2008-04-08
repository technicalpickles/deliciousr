module Deliciousr
  class Post
    attr_accessor :href, :description, :extended, :hash, :date, :tags
    
    def initialize(params={})
      params.each_pair do |key, value|
        send "#{key}=", value
      end
      
      if tags_string = params[:tags]
        @tags = tags_string.split(' ').inject([]) do |result, name|
          result + [Tag.new(name, nil)]
        end
      end
    end
    
    def self.parse(node)

    end
  end
end