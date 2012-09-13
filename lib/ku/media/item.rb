require_relative 'searchable'

module KU
  module Media
    class Item < Sequel::Model
      extend Searchable

      plugin :optimistic_locking
  
      many_to_one :collection
      many_to_one :category
      many_to_one :language
      
      many_to_many :authors, class: Person
      many_to_many :keywords
      many_to_many :tags
      many_to_many :links
  
      one_to_one :asset
      one_to_many :consents
  
      searchable :title, :summary
    end
  end
end
