require 'open-uri'
require 'addressable/uri'
require 'nokogiri'

module KU
  module Media
    module Helpers
      class URLScraper
      
        def initialize url
          @url = Addressable::URI.parse(url).normalize
        end
      
        def title
          element = query 'title'
          element ? element.text : 'untitled'
        end
      
        private
      
        def query selector
          doc.at_css selector
        end
      
        def doc
          @doc ||= Nokogiri::HTML body
        end
      
        def body
          @body ||= data.read
        end
      
        def data
          open(@url)
        rescue SocketError
          StringIO.new
        end
      end
    end
  end
end