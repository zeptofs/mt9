# frozen_string_literal: true

require "fixy"

require_relative "mt9/version"
require_relative "mt9/base_record"
require_relative "mt9/header_record"
require_relative "mt9/validators"

module MT9
  class ValidationError < StandardError
    attr_reader :result

    def initialize(result)
      @result = result
      errors = result.errors.messages.map { |message| "#{message.path.join('.')} #{message.text}" }
      super("Validation failed: #{errors.join(', ')}")
    end
  end
end
