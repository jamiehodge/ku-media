require_relative 'file_store/client'

module KU
  module Media
    class Proxy < Sequel::Model
      attr_accessor :tempfile
      
      unrestrict_primary_key
      
      many_to_one :asset
      many_to_one :format
      
      def path
        store.get(asset_id, name).path unless new?
      end
      
      def name
        "#{asset.basename}-#{format.id}.#{format.extension}"
      end
      
      private
      
      def after_save
        store.set asset_id, name, tempfile
      end
      
      def after_destroy
        store.delete asset_id, name
      end
      
      def store
        FileStore::Client.new ENV['KU_MEDIA_FILE_STORE']
      end
    end
  end
end
