# frozen_string_literal: true

require_relative "lib/alphabetical_schema/version"

Gem::Specification.new do |spec|
  spec.name          = "alphabetical_schema"
  spec.version       = AlphabeticalSchema::VERSION
  spec.authors       = ["Fabian Schwahn"]
  spec.email         = ["fabian.schwahn@gmail.com"]

  spec.summary       = "Sort schema.rb alphabetically to prevent conflicts"
  spec.homepage      = "https://github.com/denkungsart/alphabetical_schema"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "< 8"

  spec.add_development_dependency "appraisal"
  spec.add_development_dependency "combustion", "~> 1.3"
  spec.add_development_dependency "rspec-rails"
end
