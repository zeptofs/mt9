# frozen_string_literal: true

require "dry-validation"
require "fixy"

require_relative "mt9/base_record"
require_relative "mt9/header_record"
require_relative "mt9/version"

module MT9
  class ValidationError < StandardError
    attr_reader :result

    def initialize(result)
      @result = result
      errors = result.errors(full: true).messages
      super("Validation failed: #{errors.join(', ')}")
    end
  end
end
