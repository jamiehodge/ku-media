require_relative 'searchable'

module KU
  module Media
    class Collection < Sequel::Model
      extend Searchable
  
      plugin :optimistic_locking
      
      one_to_many :items
      
      many_to_many :authors, class: Group
      many_to_many :keywords
      many_to_many :tags
      many_to_many :links
      
      searchable :title, :summary
    end
  end
end

