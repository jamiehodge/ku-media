module KU
  module Media
    class Language < Sequel::Model
      unrestrict_primary_key
      
      plugin :static_cache
      
      one_to_many :items
    end
  end
end
