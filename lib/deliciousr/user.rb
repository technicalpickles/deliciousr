module Deliciousr
  class User
    attr_accessor :username, :password
    
    def initialize(username, password)
      @username = username
      @password = password
    end
    
    def tags
      Deliciousr::V1::Tags::GetTagsCall.new(self).call
    end
    
    def last_updated
      Deliciousr::V1::Posts::LastUpdated.new(self).call
    end
    
    def recent_posts
      Deliciousr::V1::Posts::Recent.new(self).call
    end
  end
end