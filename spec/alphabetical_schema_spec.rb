RSpec.describe AlphabeticalSchema do
  it "creates an alphabetically sorted schema" do
    expected_lines = File.readlines("spec/expected_schema/schema_6.1.rb")

    puts `cd spec/internal && rake db:migrate`

    generated_lines = File.readlines("spec/internal/db/schema.rb")

    generated_lines.zip(expected_lines).each do |generated, expected|
      expect(generated).to eq(expected)
    end
  end
end
