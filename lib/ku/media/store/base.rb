require_relative 'media'

require 'forwardable'
require 'pathname'

module KU
  module Media
    module Store
      class Base
        
        extend Forwardable
        def_delegators :path, :directory?, :exist?, :size
      
        attr_reader :path
      
        def initialize path='default_file_store', representation=Media
          @path = Pathname(path)
          @representation = representation
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
          nil
        end
      
        def << media
          @representation.create self, media
        end
      
        def [] media
          @representation.new self, media
        end
      
        def - media
          @representation.new(self, media).delete
        end
      end
    end
  end
end

