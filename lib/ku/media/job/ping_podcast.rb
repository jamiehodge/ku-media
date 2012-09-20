require_relative 'base'

require_relative '../http/client'

module KU
  module Media
    module Job
      class PingPodcast < Base
    
        def initialize client=KU::Media::HTTP::Client, options
          @client = client
          @url = options['url']
        end
    
        def perform
          logger.debug ping_url
        end
    
        private
        
        def ping_url
          @client.new(url).get cache: false
        end
        
        def url
          "#{server}?feedURL=#{@url}"
        end
        
        def server
          ENV['PING_PODCAST_SERVER_URL']
        end
      end
    end
  end
end
