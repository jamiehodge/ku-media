require_relative 'helpers/storable'

module KU
  module Media
    class Proxy < Sequel::Model
      extend Storable
  
      many_to_one :asset
      many_to_one :format
      
      def store
        ENV['KU_MEDIA_PROXY_STORE']
      end
    end
  end
end
