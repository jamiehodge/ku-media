require_relative 'file_store/client'

module KU
  module Media
    class Asset < Sequel::Model
      attr_accessor :tempfile
      
      many_to_one :item
      
      one_to_many :proxies
      
      plugin :association_dependencies, proxies: :destroy
      
      def path
        store.get(id, name).path unless new?
      end
      
      def basename
        File.basename name, extension
      end
      
      def extension
        File.extname name
      end
      
      def video?
        !!(type =~ /^video/)
      end
      
      def audio?
        !!(type =~ /^audio/)
      end
      
      def image?
        !!(type =~ /^image/)
      end
      
      private
      
      def after_save
        super
        store.set id, name, tempfile
      end
      
      def after_destroy
        super
        store.delete id, name
        store.delete id
      end
      
      def store
        FileStore::Client.new ENV['KU_MEDIA_FILE_STORE']
      end
    end
  end
end
