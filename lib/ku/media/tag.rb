module KU
  module Media
    class Tag < Sequel::Model
      unrestrict_primary_key
      
      many_to_many :collections
      many_to_many :items
    end
  end
end
