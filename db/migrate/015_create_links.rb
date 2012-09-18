require 'uri'

Sequel.migration do
  up do
    create_table :links do
      citext :url, primary_key: true
      
      Integer :lock_version, default: 0
        
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      
      validate do
        presence :url
        max_length 255, :url
        format %r{^(([^:/?#]+):)(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?}, :url
      end
    end
    
    create_trigger :links, :timestamp, :moddatetime, args: :updated_at, each_row: true, events: :update
  end
  
  down do
    drop_trigger :links, :timestamp
    drop_table :links
  end
end
