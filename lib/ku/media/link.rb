require 'open-uri'
require 'addressable/uri'
require 'nokogiri'

module KU
  module Media
    class Link < Sequel::Model
      unrestrict_primary_key
      
      many_to_many :collections
      many_to_many :items
      
      def before_save
        self.name = url_title
        super
      end
      
      private
      
      def url_title
        return 'untitled' unless element = Nokogiri::HTML(url_body).at_css('title')
        element.text
      end
      
      def url_body
        open(normalized_url).read
      end
      
      def normalized_url
        Addressable::URI.parse(url).normalize
      end
    end
  end
end
