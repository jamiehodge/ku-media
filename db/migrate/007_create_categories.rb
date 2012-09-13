Sequel.migration do
  change do
    create_table :categories do
      Integer :id, primary_key: true
      
      String :name, null: false
      
      validate do
        presence [:id, :name]
        length_range 1..255, :name
      end
    end
  end
end
