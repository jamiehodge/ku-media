require_relative 'base'
require_relative 'group'
require_relative 'file'

module KU
  module Media
    module FileStore
      class Client
        
        def initialize path
          @base = Base.create path
        end
    
        def get id, name
          File.new(group(id), name)
        end
    
        def set id, name, file
          File.create(group(id), name, file)
        end
    
        def delete id, name=nil
          if name
            File.new(group(id), name).delete
          else
            group(id).delete
          end
        end
    
        private
    
        def group id
          Group.create(@base, id)
        end
      end
    end
  end
end
