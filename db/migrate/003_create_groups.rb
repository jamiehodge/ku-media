Sequel.migration do
  change do
    create_table :groups do
      citext :id, primary_key: true
      
      validate do
        presence :id
      end
    end
  end
end
