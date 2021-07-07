require "rails"

module AlphabeticalSchema
  class Railtie < Rails::Railtie
    railtie_name :alphabetical_schema
    rake_tasks do
      load "alphabetical_schema/tasks/db.rake"
    end
  end
end
