module KU
  module Media
    class Consent < Sequel::Model
      unrestrict_primary_key
      
      plugin :optimistic_locking
      
      many_to_one :item
      many_to_one :author
      many_to_one :license
    end
  end
end
