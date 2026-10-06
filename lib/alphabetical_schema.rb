# frozen_string_literal: true

require "alphabetical_schema/version"
require "delegate"

module AlphabeticalSchema
  class SortedConnection < SimpleDelegator
    # Rails < 8.2 reads the columns of one table at a time. Later versions pass
    # all table names at once and receive a hash of columns by table name.
    def columns(table_names)
      columns = super
      if columns.is_a?(Hash)
        columns.transform_values { |table_columns| sort(table_columns) }
      else
        sort(columns)
      end
    end

    private
      def sort(columns)
        columns.sort_by(&:name)
      end
  end

  module SchemaDumperPatch
    def initialize(*)
      super
      @connection = ::AlphabeticalSchema::SortedConnection.new(@connection)
    end
  end
end

require "active_record/schema_dumper"
ActiveRecord::SchemaDumper.prepend(::AlphabeticalSchema::SchemaDumperPatch)
