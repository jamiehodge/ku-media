Sequel.migration do
  up do
    create_table :proxies do
      foreign_key :asset_id, :assets, null: false, on_delete: :cascade, index: true 
      foreign_key :format_id, :formats, type: :citext, null: false, on_delete: :cascade, index: true
      
      String      :name, null: false
      String      :type, null: false
      Fixnum      :size, null: false
      
      Integer     :lock_version, default: 0
      
      DateTime    :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime    :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      
      check { size > 0 }
      
      primary_key [:asset_id, :format_id]
      
      validate do
        presence [:name, :type, :size, :asset_id]
        max_length 255, [:name, :type]
        format /^[-\w.+]+\/[-\w.+]*$/, :type
      end
    end

    create_trigger :proxies, :timestamp, :moddatetime, args: :updated_at, each_row: true, events: :update
  end
  
  down do
    drop_trigger :proxies, :timestamp
    drop_table :proxies
  end
end
