module Deliciousr
  module V1
    module Posts
      class PostsApiCall < ApiCall        
        method :posts
        
        def parse_post(node)
          # params = Post.attrs.inject({}) do |params, current|
          #   params[current] = node.attributes[current.to_s]
          # end
          
          attrs = node.attributes

          Post.new(
          :href => attrs['href'], :description => attrs['description'], :extended => attrs['extended'], :hash => attrs['hash'], :date => attrs['time'], :tags => attrs['tag']
          )
        end
      end
      
      class LastUpdated < PostsApiCall
        required  :none
        optional  :none
        action    :update
        
        def parse(root)
          DateTime.parse(root.attributes['time'])
        end
      end
      
      class Recent < PostsApiCall
        required  :none
        optional  :tag, :count
        action    :recent
        
        @@parameter_mappings = {}
        
        def parse(root)
          results = []
          root.each_element('post') do |element|
            results << parse_post(element)
          end
          results
        end
      end
      
      class Get < PostsApiCall
        required  :none
        optional  :tag, :date, :url
        action    :get
        
        @@parameters_mappings = {:date => :dt}
      end
      
      class All < PostsApiCall
        required :none
        optional :tag
        action :all
        
        @@parameter_mappings = {}
      end
      
      class Dates < PostsApiCall
        required  :none
        optional  :tag
        action    :dates
        
        @@parameter_mappings = {}
      end
      
      class Add < PostsApiCall
        required  :url, :description
        optional  :extended, :tags, :date, :replace, :shared
        action    :add
        @@parameter_mappings = {:date => :dt}
      end
      
      class Delete < PostsApiCall
        required  :url
        optional  :none
        action    :delete
      end
    end
  end
end