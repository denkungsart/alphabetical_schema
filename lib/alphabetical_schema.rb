# frozen_string_literal: true

require "alphabetical_schema/version"
require "delegate"

module AlphabeticalSchema
  class SortedConnection < SimpleDelegator
    def columns(table_name)
      super.sort_by(&:name)
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
