Sequel.migration do
  up do
    create_table :items do
      primary_key :id
      
      foreign_key :collection_id, :collections, null: false, on_delete: :cascade, index: true
      foreign_key :category_id, :categories, null: false, on_delete: :cascade, index: true
      # foreign_key [:subcategory_id, :subcategory_category_id], :subcategories, on_delete: :cascade, index: true
      foreign_key :language_id, :languages, type: :citext, null: false, index: true
        
      String      :title,       null: false
      String      :description, null: false
      FalseClass  :explicit,    default: false
      
      Integer     :lock_version, default: 0
      
      DateTime    :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime    :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      
      # index [:subcategory_id, :subcategory_category_id]
      
      validate do
        presence [:title, :description, :collection_id, :category_id, :language_id]
        max_length 255, [:title, :description]
      end
      
      full_text_index [:title, :description]
    end
    
    create_trigger :items, :timestamp, :moddatetime, args: :updated_at, each_row: true, events: :update
  end
  
  down do
    drop_trigger :items, :timestamp
    drop_table :items
  end
end
