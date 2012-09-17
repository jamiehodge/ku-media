require 'open-uri'
require 'addressable/uri'
require 'nokogiri'
require 'digest/md5'

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
          @doc ||= Nokogiri::HTML data
        end
      
        def data
          Cache.fetch(key: "link_#{@url}") { open(@url).read }
        rescue SocketError
          StringIO.new
        end
      end
    end
  end
end