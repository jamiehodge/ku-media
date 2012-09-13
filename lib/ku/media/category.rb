module KU
  module Media
    class Category < Sequel::Model
      unrestrict_primary_key
      
      plugin :static_cache
      
      one_to_many :items
      
      one_to_many :subcategories
    end
  end
end
