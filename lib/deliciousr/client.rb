module Deliciousr
  class Client
    def initialize(username, password)
      @username = username
      @password = password
    end

    def tags
      xml = RestClient.get "https://#{@username}:#{@password}@api.del.icio.us/v1/tags/get"
      Tag.parse(xml)
    end
  end
end
