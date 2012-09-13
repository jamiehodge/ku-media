module KU
  module Media
    class Subcategory < Sequel::Model
      unrestrict_primary_key
      
      plugin :static_cache
      
      many_to_one :category
    end
  end
end
