module Deliciousr
  class Tag
    include HappyMapper
    
    tag 'tag'
    attribute 'name', String, :tag => :tag
    attribute 'count', Integer
  end
end
