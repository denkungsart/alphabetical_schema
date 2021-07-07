module AlphabeticalSchema
  module SchemaDumper
    class SortedConnection < SimpleDelegator
      def columns(table_name)
        __getobj__.columns(table_name).sort_by(&:name)
      end
    end

    def table(table, stream)
      original_connection = @connection
      @connection = SortedConnection.new(original_connection)
      super
    ensure
      @connection = original_connection
    end
  end
end
