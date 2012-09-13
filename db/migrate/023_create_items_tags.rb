Sequel.migration do
  change do
    create_table :items_tags do
      foreign_key :item_id, :items, null: false, on_delete: :cascade
      foreign_key :tag_id, :tags, type: :citext, null: false, on_update: :cascade, on_delete: :cascade
      
      primary_key [:item_id, :tag_id]
    end
  end
end
