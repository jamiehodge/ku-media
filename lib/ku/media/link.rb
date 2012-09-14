require_relative 'helpers/url_scraper'

module KU
  module Media
    class Link < Sequel::Model
      unrestrict_primary_key
      
      many_to_many :collections
      many_to_many :items
      
      def before_validation
        self.title = Helpers::URLScraper.new(url).title
        super
      end
    end
  end
end
