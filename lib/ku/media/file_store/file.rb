module KU
  module Media
    module FileStore
      class File
        
        BUFFER_SIZE = 4096
  
        extend Forwardable
        def_delegators :path, :open, :read, :size
  
        def initialize group, name, file=nil
          @group, @name, @file = group, name, file
        end
  
        def self.create group, name, file
          new(group, name, file).save
        end
  
        def save
          write_file if @file
          self
        end
  
        def delete
          path.delete if path.file?
          self
        end
  
        def path
          @group.path + @name
        end
  
        private
  
        def write_file
          path.open 'w' do |f|
            begin
              f.flock ::File::LOCK_EX
              f.write(@file.read(BUFFER_SIZE)) until @file.eof?
            ensure
              f.flock ::File::LOCK_UN
            end
          end
        end
      end
    end
  end
end
