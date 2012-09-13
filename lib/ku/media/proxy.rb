module KU
  module Media
    class Proxy < Sequel::Model
  
      many_to_one :asset
      many_to_one :format
    end
  end
end
