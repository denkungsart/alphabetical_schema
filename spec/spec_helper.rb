require "bundler"

require "active_support/all"

Bundler.require :default, :development

Combustion.initialize! :all

require "rspec/rails"

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
