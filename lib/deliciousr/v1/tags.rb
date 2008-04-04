module Deliciousr
  module V1
    module Tags
      class TagsApiCall < ApiCall
        def method
          :tags
        end
      end
      
      class GetTagsCall < TagsApiCall
        required  :none
        optional  :none
        action    :get
        
        def parse(root)
          results = []
          root.get_elements('tag').each do |tag_element|
            tag = ::Deliciousr::Tag.new(tag_element.attributes['tag'], tag_element.attributes['count'].to_i)
            tag.user = @user
            results << tag
          end
          results
        end
      end
      
      class RenameTagsCall < TagsApiCall
        required  :old, :new
        optional  :none
        action    :rename
        
        def parse(root)
          root.text == 'done'
        end
      end
      
    end
  end
end