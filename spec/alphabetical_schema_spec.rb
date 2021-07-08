RSpec.describe AlphabeticalSchema do
  let(:schema_path) { "#{__dir__}/internal/db/schema.rb" }
  let(:expected_schema_path) { "#{__dir__}/expected_schema.rb" }

  around do |example|
    original_schema = File.read(schema_path)
    example.run
    File.write(schema_path, original_schema)
  end

  it "creates an alphabetically sorted schema" do
    Dir.chdir("#{__dir__}/internal") do
      system("rake db:migrate")
    end

    expected_lines = File.readlines(expected_schema_path)
    generated_lines = File.readlines(schema_path)

    expected_lines.zip(generated_lines).each do |expected, generated|
      # Disregard differences in comments in schema.rb as those regularly change between rails versions
      next if generated&.start_with?("#")

      expect(generated).to eq(expected)
    end
  end
end
