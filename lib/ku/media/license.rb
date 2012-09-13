module KU
  module Media
    class License < Sequel::Model
      unrestrict_primary_key
      
      plugin :static_cache
      
      one_to_many :consents
    end
  end
end
