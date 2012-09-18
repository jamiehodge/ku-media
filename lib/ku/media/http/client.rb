require 'socket'
require 'addressable/uri'
require 'net/http'

module KU
  module Media
    module HTTP
      class Client
      
        def initialize url
          @url = Addressable::URI.parse(url).normalize
        end
      
        def valid?
          !!IPSocket.getaddress(@url.host)
        rescue SocketError
          false
        end
      
        def get
          Cache.fetch(key: @url.to_s) { fetch @url }
        end
      
        private
      
        def fetch uri_str, limit = 10
          raise ArgumentError, 'too many HTTP redirects' if limit == 0
        
          response = Net::HTTP.get_response(URI(uri_str))
        
          case response
          when Net::HTTPSuccess then
            response
          when Net::HTTPRedirection then
            location = response['location']
            fetch(location, limit - 1)
          else
            response.value
          end
        end
      end
    end
  end
end
