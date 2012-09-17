require_relative '../store'

module KU
  module Media
    module Storable
  
      attr_accessor :tempfile
  
      def after_save
        store << self
      end
  
      def after_destroy
        store - self
      end

      def path
        store[self].path
      end
    end
  end
end
