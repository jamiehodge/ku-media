module KU
  module Media
    module FileStore
      class Base
        
        attr_reader :path
  
        def initialize path
          @path = Pathname(path)
        end
  
        def self.create path
          new(path).save
        end
  
        def save
          path.mkpath
          self
        end
  
        def delete
          path.delete
          self
        end
      end
    end
  end
end
