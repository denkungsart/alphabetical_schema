namespace :db do
  task :alphabetical_schema do
    require "active_record/schema_dumper"
    ActiveRecord::SchemaDumper.prepend(AlphabeticalSchema::SchemaDumper)
  end
end

Rake::Task["db:schema:dump"].enhance(["db:alphabetical_schema"]) if Rake::Task.task_defined?("db:schema:dump")
