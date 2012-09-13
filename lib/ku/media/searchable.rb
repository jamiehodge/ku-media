module KU
  module Media
    module Searchable
      
      def searchable *cols
        def_dataset_method :search do |query|
          return self if query.blank?
          full_text_search(cols, query.split.map {|q| "#{q}:*"})
        end
      end
    end
  end
end
