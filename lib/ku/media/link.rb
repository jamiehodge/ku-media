require_relative 'cache'
require_relative 'http/client'
require_relative 'http/parser'

module KU
  module Media
    class Link < Sequel::Model
      
      many_to_many :collections
      many_to_many :items
      
      def title
        HTTP::Parser.new(body).title
      end
      
      def validate
        super
        errors.add(:url, 'does not exist') unless client.valid_url?
      end
      
      private
      
      def client
        HTTP::Client.new url
      end
      
      def body
        client.get.body
      end
    end
  end
end
