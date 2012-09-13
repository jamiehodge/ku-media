Sequel.migration do
  up do
    create_table :approvals do
      foreign_key :item_id, :items, null: false, on_delete: :cascade, index: true
      foreign_key :author_id, :people, type: :citext, null: false, on_delete: :cascade, index: true
      foreign_key :license_id, :licenses, type: :citext, null: false, on_delete: :cascade, index: true
      
      primary_key [:item_id, :author_id]
      
      validate do
        presence [:item_id, :author_id, :license_id]
      end
    end
    
    create_trigger :approvals, :timestamp, :moddatetime, args: :updated_at, each_row: true, events: :update
  end
  
  down do
    drop_trigger :approvals, :timestamp
    drop_table :approvals
  end
end
