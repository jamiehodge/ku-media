Sequel.migration do
  up do
    create_table :collections do
      primary_key :id
        
      String      :title,       null: false
      String      :description, null: false
      
      Integer     :lock_version, default: 0
      
      DateTime    :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime    :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      
      validate do
        presence [:title, :description]
      end
      
      full_text_index [:title, :description]
    end
    
    create_trigger :collections, :timestamp, :moddatetime, args: :updated_at, each_row: true, events: :update
  end
  
  down do
    drop_trigger :collections, :timestamp
    drop_table :collections
  end
end
