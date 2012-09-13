Sequel.migration do
  up do
    create_table :tags do
      citext :name, primary_key: true
      
      Integer :lock_version, default: 0
        
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      
      validate do
        presence :name
        max_length 255, :name
      end
      
      full_text_index :name
    end
    
    create_trigger :tags, :timestamp, :moddatetime, args: :updated_at, each_row: true, events: :update
  end
  
  down do
    drop_trigger :tags, :timestamp
    drop_table :tags
  end
end
