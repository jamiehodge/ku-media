Sequel.migration do
  change do
    create_table :collections_keywords do
      foreign_key :collection_id, :collections, null: false, on_delete: :cascade
      foreign_key :keyword_id, :keywords, type: :citext, null: false, on_update: :cascade, on_delete: :cascade
      
      primary_key [:collection_id, :keyword_id]
    end
  end
end
