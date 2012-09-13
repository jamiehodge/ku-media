require_relative 'searchable'

module KU
  module Media
    class Format < Sequel::Model
      extend Searchable
      
      unrestrict_primary_key
      
      one_to_many :proxies
      
      searchable :name
    end
  end
end
