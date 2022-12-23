# frozen_string_literal: true

MIGRATIONS_PATH = 'db/migrations'.freeze

db = ENV.fetch('DB_URL', 'sqlite://db/drugs_list_dev.db')

begin
  DB = Sequel.connect(db)
rescue Sequel::DatabaseConnectionError => e
  if e.message.match?(/database .* does not exist/i)
    puts "Error connecting to database: #{e.message}"
    puts 'Reconnecting...'
    DB = Sequel.connect(db)
  else
    raise e
  end
end

if DB
  Sequel.extension :migration
  Sequel::Migrator.run(DB, MIGRATIONS_PATH, use_transactions: true)
end
