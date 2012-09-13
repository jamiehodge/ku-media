require 'forwardable'
require 'ku/ldap'

require_relative 'group'

module KU
  module Media
    class Person < Sequel::Model
      unrestrict_primary_key
      
      extend Forwardable
      
      DIRECTORY = KU::LDAP
      
      def_delegators :entry, :first_name, :last_name, :full_name, :title,
          :primary_institution, :department, :email, :group_name
          
      many_to_many :items, key: :author_id
          
      def self.authenticate id, password
        self.find_or_create(id: id) if DIRECTORY.authenticate_user id, password
      end
      
      def group
        Group.new group_name
      end
      
      def admin?
        Group.admin_group.member? id
      end
      
      private
      
      def entry
        DIRECTORY.user id
      end
    end
  end
end
