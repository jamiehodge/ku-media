Sequel.migration do
  change do
    create_table :items_links do
      foreign_key :item_id, :items, null: false, on_delete: :cascade
      foreign_key :link_id, :links, type: :citext, null: false, on_update: :cascade, on_delete: :cascade
      
      primary_key [:item_id, :link_id]
    end
  end
end
