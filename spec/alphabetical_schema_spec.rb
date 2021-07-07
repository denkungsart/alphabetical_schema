RSpec.describe AlphabeticalSchema do
  let(:schema_path) { "spec/internal/db/schema.rb" }

  around do |example|
    original_schema = File.read(schema_path)
    example.run
    File.write(schema_path, original_schema)
  end

  it "creates an alphabetically sorted schema" do
    expected_lines = File.readlines("#{__dir__}/expected_schema/schema_6.1.rb")

    Dir.chdir("#{__dir__}/internal") do
      system("rake db:migrate")
    end

    generated_lines = File.readlines(schema_path)
    generated_lines.zip(expected_lines).each do |generated, expected|
      expect(generated).to eq(expected)
    end
  end
end
