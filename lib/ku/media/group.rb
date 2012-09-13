require 'forwardable'
require 'ku/ldap'

module KU
  module Media
    class Group < Sequel::Model
      extend Forwardable
      
      DIRECTORY = KU::LDAP
      
      def_delegators :entry, :description, :members, :member?
      
      many_to_many :collections, key: :author_id
      
      def self.admin_group
        self[ENV['LDAP_ADMIN_GROUP'] || 'fak-itm-editor']
      end
      
      private
      
      def entry
        DIRECTORY.group id
      end
    end
  end
end
