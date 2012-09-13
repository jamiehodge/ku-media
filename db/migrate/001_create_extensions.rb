Sequel.migration do
  up do
    extension :constraint_validations
    create_constraint_validations_table
    
    run 'CREATE EXTENSION moddatetime'
    run 'CREATE EXTENSION citext'
    run 'CREATE EXTENSION hstore'
  end
  down do
    run 'DROP EXTENSION hstore'
    run 'DROP EXTENSION citext'
    run 'DROP EXTENSION moddatetime'
    
    extension :constraint_validations
    drop_constraint_validations_table
  end
end
