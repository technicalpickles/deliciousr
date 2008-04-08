module Deliciousr
  module V1
    module Posts
      class PostsApiCall < ApiCall        
        method :posts
      end
      
      def parse_post(node)
        params = Post.attrs.inject({}) do |params, current|
          params[current] = node.attributes[attribute.to_s]
        end

        Post.new(params)
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