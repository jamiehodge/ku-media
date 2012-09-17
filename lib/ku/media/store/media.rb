require 'forwardable'
require 'pathname'
require 'ostruct'

module KU
  module Media
    module Store
      class Media
          
        BUFFER_SIZE = 4096
      
        extend Forwardable
        def_delegators :path, :exist?, :file?, :open, :read, :size
      
        def initialize store, media
          @store = store
        
          media = OpenStruct.new(media) if media.kind_of? Hash
        
          @id = media.id
          @name = media.name
          @tempfile = media.tempfile
        end
      
        def self.create store, media
          new(store, media).save
        end
      
        def save
          make_dir
          write_file
          self
        end
      
        def delete
          path.delete if path.file?
          path.dirname.delete
          nil
        end
      
        def path
          @store.path + dir_name(100) + dir_name + @name
        end
      
        private
      
        def make_dir
          path.dirname.mkpath
        end
      
        def write_file
          path.open 'a' do |f|
            begin
              f.flock ::File::LOCK_EX
              f.write(@tempfile.read(BUFFER_SIZE)) until @tempfile.eof?
            ensure
              f.flock ::File::LOCK_UN
            end
          end
        end
      
        def dir_name divisor=1
          (@id.to_i / divisor).to_s
        end
      end
    end
  end
end