require_relative 'helpers/storable'

module KU
  module Media
    class Asset < Sequel::Model
      extend Storable
      
      many_to_one :item
      
      one_to_many :proxies
      
      def store
        ENV['KU_MEDIA_ASSET_STORE']
      end
    end
  end
end
