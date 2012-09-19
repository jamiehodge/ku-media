Sequel.migration do
  up do
    create_table :formats do
      citext :id, primary_key: true
      
      citext :extension, null: false
      hstore :options, null: false
      
      Integer :lock_version, default: 0
        
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      
      validate do
        presence [:id, :options]
      end
      
      full_text_index [:id, :extension]
    end
    
    create_trigger :formats, :timestamp, :moddatetime, args: :updated_at, each_row: true, events: :update
  end
  
  down do
    drop_trigger :formats, :timestamp
    drop_table :formats
  end
end
