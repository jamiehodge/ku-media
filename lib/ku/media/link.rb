require_relative 'cache'
require_relative 'helpers/url_scraper'

module KU
  module Media
    class Link < Sequel::Model
      unrestrict_primary_key
      
      many_to_many :collections
      many_to_many :items
      
      def title
        Cache.fetch key: 'link_title' do
          Helpers::URLScraper.new(url).title
        end
      end
    end
  end
end
