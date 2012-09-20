require_relative 'helpers/searchable'

module KU
  module Media
    class Collection < Sequel::Model
      extend Searchable
  
      plugin :optimistic_locking
      plugin :touch
      
      one_to_many  :items,    after_add: :nudge, after_remove: :nudge
      
      many_to_many :authors, class: Group, right_key: :group_id,
          after_add: :nudge, after_remove: :nudge
          
      many_to_many :keywords, after_add: :nudge, after_remove: :nudge
      many_to_many :tags,     after_add: :nudge, after_remove: :nudge
      many_to_many :links,    after_add: :nudge, after_remove: :nudge
      
      searchable :title, :description
      
      def nudge column=nil
        touch
      end
    end
  end
end

