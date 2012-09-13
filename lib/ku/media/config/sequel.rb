require 'sequel'

module KU
  module Media
    Sequel.extension :pagination, :blank

    DB = Sequel.connect ENV['DATABASE_URL'] || 'postgres://localhost/ku-media'
    DB.extension :pg_hstore

    class Sequel::Model
  
      plugin :constraint_validations
      self.raise_on_typecast_failure = false
  
      plugin :prepared_statements
      plugin :prepared_statements_associations
  
      plugin :string_stripper
    end
  end
end    


