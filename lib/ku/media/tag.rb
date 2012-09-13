module KU
  module Media
    class Tag < Sequel::Model
      
      many_to_many :collections
      many_to_many :items
    end
  end
end
