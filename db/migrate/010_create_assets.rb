Sequel.migration do
  up do
    create_table :assets do
      primary_key :id
      
      foreign_key :item_id, :items, null: false, on_delete: :cascade, index: true
        
      String      :name, null: false
      String      :type, null: false
      Fixnum      :size, null: false
      
      Integer     :lock_version, default: 0
      
      DateTime    :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime    :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      
      check { size > 0 }
      
      validate do
        presence [:name, :type, :size, :item_id]
        max_length 255, [:name, :type]
        format /^[-\w.+]+\/[-\w.+]*$/, :type
      end
      
      full_text_index [:name, :type]
    end
    
    create_trigger :assets, :timestamp, :moddatetime, args: :updated_at, each_row: true, events: :update
  end
  
  down do
    drop_trigger :assets, :timestamp
    drop_table :assets
  end
end
