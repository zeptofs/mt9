# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  enable_coverage :branch
  coverage_criterion :branch

  add_filter "/spec/"
  minimum_coverage(line: 100, branch: 100)
end

require "mt9"
require "pry-byebug"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
