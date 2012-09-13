require 'queue_classic/tasks'

ENV['DATABASE_URL'] ||= 'postgres://localhost/ku-media'

namespace :qc do

  desc 'Environment'
  task :environment do
    # require_relative 'lib/ku/media/config/queue_classic'
  end
end

namespace :db do
  
  desc 'Environment'
  task :environment do
    require 'sequel'
    require 'pg'
    
    DB = Sequel.connect ENV['DATABASE_URL']
    DB.extension :pg_array, :pg_row, :pg_hstore
  end
  
  desc 'Seed database'
  task seed: :environment do
    require_relative '../../../db/seed'
  end
  
  namespace :migrate do
    
    desc 'Environment'
    task environment: :'db:environment' do
      Sequel.extension :migration, :constraint_validations, :pg_hstore
    end
    
    desc 'Automigrate database'
    task auto: :environment do
      Sequel::Migrator.run DB, 'db/migrate', target: 0
      Sequel::Migrator.run DB, 'db/migrate'
      Rake::Task['db:seed'].invoke
    end
    
    desc 'Migrate to'
    task :to, [:target] => :environment do |t, args|
      Sequel::Migrator.run DB, 'db/migrate', target: args[:target]
    end
    
    desc 'Migrate up'
    task up: :environment do
      Sequel::Migrator.run DB, 'db/migrate'
    end
    
    desc 'Migrate down'
    task down: :environment do
      Sequel::Migrator.run DB, 'db/migrate', target: 0
    end
  end
  
  task migrate: 'migrate:up'
end