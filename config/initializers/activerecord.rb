# Automigrate if needs migration
if ActiveRecord::Migrator.needs_migration?
  ActiveRecord::Migrator.migrate(File.join(Rails.root, 'db/migrate'))
end
