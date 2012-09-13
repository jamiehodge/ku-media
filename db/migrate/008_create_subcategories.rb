Sequel.migration do
  change do
    create_table :subcategories do
      Integer :id
      
      foreign_key :category_id, :categories, null: false, on_delete: :cascade, index: true
      
      String :name, null: false
      
      primary_key [:id, :category_id]
      
      validate do
        presence [:id, :category_id, :name]
        max_length 255, :name
      end
    end
  end
end
