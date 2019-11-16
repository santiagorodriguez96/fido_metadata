# frozen_string_literal: true

require "bundler/setup"
require "fido_metadata"

require "pry-byebug"
require_relative "support/test_cache_store"
require "webmock/rspec"

SUPPORT_PATH = Pathname.new(File.expand_path(File.join(__dir__, "support")))

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = "tmp/.rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before do
    FidoMetadata.configure do |metadata_config|
      metadata_config.cache_backend = TestCacheStore.new
    end
  end

  config.after do
    FidoMetadata.instance_variable_set(:@configuration, nil)
  end
end