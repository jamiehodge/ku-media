Sequel.migration do
  change do
    create_table :items_keywords do
      foreign_key :item_id, :items, null: false, on_delete: :cascade
      foreign_key :keyword_id, :keywords, type: :citext, null: false, on_update: :cascade, on_delete: :cascade
      
      primary_key [:item_id, :keyword_id]
    end
  end
end
