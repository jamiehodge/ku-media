Sequel.migration do
  change do
    create_table :collections_tags do
      foreign_key :collection_id, :collections, null: false, on_delete: :cascade
      foreign_key :tag_id, :tags, type: :citext, null: false, on_update: :cascade, on_delete: :cascade
      
      primary_key [:collection_id, :tag_id]
    end
  end
end
