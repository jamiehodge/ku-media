Sequel.migration do
  up do
    create_table :keywords do
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
    
    create_trigger :keywords, :timestamp, :moddatetime, args: :updated_at, each_row: true, events: :update
  end
  
  down do
    drop_trigger :keywords, :timestamp
    drop_table :keywords
  end
end
