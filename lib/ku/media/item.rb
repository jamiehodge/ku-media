require_relative 'helpers/searchable'

module KU
  module Media
    class Item < Sequel::Model
      extend Searchable

      plugin :optimistic_locking
      plugin :touch
  
      many_to_one :collection
      many_to_one :category
      many_to_one :language
      
      many_to_many :authors, class: Person, right_key: :person_id, 
          after_add: :nudge, after_remove: :nudge
          
      many_to_many :keywords,  after_add: :nudge, after_remove: :nudge
      many_to_many :tags,      after_add: :nudge, after_remove: :nudge
      many_to_many :links,     after_add: :nudge, after_remove: :nudge
  
      one_to_one   :asset,     after_set: :nudge, after_remove: :nudge
      one_to_many  :consents,  after_set: :nudge, after_remove: :nudge
  
      searchable :title, :description
      
      plugin :nested_attributes
      nested_attributes :asset
      
      def nudge column=nil
        touch
      end
    end
  end
end
