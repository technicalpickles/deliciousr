require 'net/https'
require 'rexml/document'

module Deliciousr
  module V1
    class ApiCall
      attr_accessor :method, :action, :parameters, :user
      attr_reader :required_parameters

      @@version = 1
      
      def initialize(user, parameters={})
        @user = user
        @parameters = parameters
        
        @http = Net::HTTP.new('api.del.icio.us', 443)
        @http.use_ssl = true
      end

      def call()
        response = do_request()
        root = as_xml(response)
        parse(root)
      end
      
      def as_xml(xml)
        REXML::Document.new(xml).root
      end
      
      def parse(xml)
        raise "Subclasses must define parse(xml)"
      end
      
      def do_request()
        @http.start do |http|
          request = Net::HTTP::Get.new(build_request_path)
          request.basic_auth(@user.username, @user.password)
          
          response = http.request(request)
          
          response.value
          response.body
        end
      end
      
      def build_request_path()
        path = "/v#{@@version}/#{self.method}/#{self.action}"
        if query_string = build_query_string
          path += "?#{query_string}"
        end
        
        path
      end
      
      def build_query_string()
        self.class.build_query_string(parameters)
      end
      
      def self.build_query_string(parameters)
        unless parameters.nil? || parameters.empty?
          
          query_strings = parameters.keys.sort {|a,b|
            a.to_s <=> b.to_s
          }.inject([]) do |result, element|
            result << "#{element}=#{parameters[element]}"
          end
          # parameters.each_pair do |key, value|
          #   query_strings << "#{key}=#{value}"
          # end
          query_strings.join('&')
        else
          nil
        end
      end
      
      # The API 'action'. Defaults to the class name, lowercased. Subclasses should use action method to change this if this default isn't sensible.
      def action
        self.class.to_s.downcase.to_sym
      end
      
      # Indicates what parameters are required
      def self.required(*parameters)
        if parameters.first == :none
          parameters = []
        end

        define_method :required_parameters do
          parameters
        end
      end
      
      # Indicates what parameters are optional
      def self.optional(*parameters)
        if parameters.first == :none
          parameters = []
        end

        define_method :optional_parameters do
          parameters
        end
      end
      
      def self.action(action)
        define_method :action do
          action
        end
      end
    end
  end
end