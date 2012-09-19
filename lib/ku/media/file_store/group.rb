module KU
  module Media
    module FileStore
      class Group
        
        def initialize base, id
          @base, @id = base, id
        end
    
        def self.create base, id
          new(base, id).save
        end
    
        def save
          path.mkpath
          self
        end
    
        def delete
          path.delete
          self
        end
    
        def path
          @base.path + (@id / 1000).to_s + @id.to_s
        end
      end
    end
  end
end
