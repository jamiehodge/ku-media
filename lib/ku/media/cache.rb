require 'dalli'

module KU
  module Media
    class Cache
      
      def self.cache
        Dalli::Client.new ENV['KU_MEDIA_CACHE_STORE']
      end
  
      def initialize options={}, &value
        raise ArgumentError, 'Invalid key' unless options[:key]
        raise ArgumentError, 'Invalid value' unless block_given?
    
        @ttl =   options.fetch(:ttl, 60*60*24*30)
        @key   = ['ku', 'media', options[:key]].join('_')
        @value = value
      end
  
      def self.fetch options={}, &value
        new(options, &value).fetch
      end
  
      def fetch
        self.class.cache.fetch @key, @ttl, &@value
      end
    end
  end
end


