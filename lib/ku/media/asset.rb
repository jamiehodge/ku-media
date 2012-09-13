require_relative 'storable'

module KU
  module Media
    class Asset < Sequel::Model
      extend Storable
      
      many_to_one :item
      
      one_to_many :proxies
    end
  end
end
