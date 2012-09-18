require 'nokogiri'

module KU
  module Media
    module HTTP
      class Parser
      
        def initialize data
          @data = data
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
          @doc ||= Nokogiri::HTML @data
        end
      end
    end
  end
end