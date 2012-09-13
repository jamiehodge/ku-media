Sequel.migration do
  change do
    create_table :collections_groups do
      foreign_key :collection_id, :collections, null: false, on_delete: :cascade
      foreign_key :group_id, :groups, type: :citext, null: false, on_delete: :cascade
      
      primary_key [:collection_id, :group_id]
    end
  end
end

