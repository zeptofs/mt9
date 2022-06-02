# frozen_string_literal: true

require "dry-validation"
require "fixy"

require "mt9/values"
require "mt9/validators/base_contract"
require "mt9/validators/header_record_contract"
require "mt9/validators/trailer_record_contract"
require "mt9/base_record"
require "mt9/header_record"
require "mt9/detail_record"
require "mt9/trailer_record"
require "mt9/version"

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
