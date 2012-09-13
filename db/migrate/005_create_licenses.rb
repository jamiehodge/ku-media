Sequel.migration do
  change do
    create_table :licenses do
      citext :id, primary_key: true
      
      String :name, null: false
      
      validate do
        presence [:id, :name]
      end
    end
  end
end
