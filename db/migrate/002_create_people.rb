Sequel.migration do
  change do
    create_table :people do
      citext :id, primary_key: true
      
      validate do
        format /^[a-z]{3}\d{3}$/, :id
      end
    end
  end
end
