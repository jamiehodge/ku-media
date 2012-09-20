require 'socket'
require 'addressable/uri'
require 'net/http'

module KU
  module Media
    module HTTP
      class Client
      
        def initialize url
          @url = Addressable::URI.parse(url.strip).normalize
        end
      
        def valid_url?
          !!IPSocket.getaddress(@url.host)
        rescue SocketError
          false
        end
      
        def get options={}
          options.merge! cache: false
          
          if options[:cache]
            Cache.fetch(key: @url.to_s) { fetch @url }
          else
            fetch @url
          end
        end
      
        private
      
        def fetch uri_str, limit = 10
          raise ArgumentError, 'too many HTTP redirects' if limit == 0
        
          uri = Addressable::URI.parse(uri_str).normalize
          
          http = Net::HTTP.new uri.host, uri.port || uri.default_port
          
          if uri.scheme == 'https'
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          end
          
          request = Net::HTTP::Get.new uri.path
          response = http.request request
        
          case response
          when Net::HTTPSuccess then
            response
          when Net::HTTPRedirection then
            location = response['location']
            warn "redirected to #{location}"
            fetch(location, limit - 1)
          else
            response.value
          end
        end
      end
    end
  end
end
