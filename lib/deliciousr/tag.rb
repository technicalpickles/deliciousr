module Deliciousr
  class Tag
    attr_accessor :name, :count, :user
    def initialize(name, count)
      @name = name
      @count = count
    end
    
    def rename_all_to!(new_name)
      V1::Tags::RenameTagsCall.new(@user, {:old => @name, :new => new_name}).call
    end
  end
end