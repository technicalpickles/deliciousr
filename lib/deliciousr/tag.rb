module Deliciousr
  class Tag
    attr_accessor :name, :count, :user
    def initialize(name, count)
      @name = name
      @count = count
    end
    
    def rename_all!(to)
      V1::Tags::RenameTagsCall.new(@user, {:old => @name, :new => to}).call
    end
  end
end