Sequel.migration do
  change do
    create_table :items_people do
      foreign_key :item_id, :items, null: false, on_delete: :cascade
      foreign_key :person_id, :people, type: :citext, null: false, on_delete: :cascade
      
      primary_key [:item_id, :person_id]
    end
  end
end
