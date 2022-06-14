# frozen_string_literal: true

require "dry-validation"
require "fixy"

require "mt9/values"
require "mt9/validators/base_contract"
require "mt9/validators/header_record_contract"
require "mt9/validators/detail_record_contract"
require "mt9/validators/trailer_record_contract"
require "mt9/base_record"
require "mt9/header_record"
require "mt9/detail_record"
require "mt9/trailer_record"
require "mt9/batch"
require "mt9/credit_batch"
require "mt9/debit_batch"
require "mt9/version"

module MT9
  def self.batch_credits(...)
    MT9::CreditBatch.new(...)
  end

  def self.batch_debits(...)
    MT9::DebitBatch.new(...)
  end

  class ValidationError < StandardError
    attr_reader :result

    def initialize(result)
      @result = result
      errors = result.errors(full: true).messages
      super("Validation failed: #{errors.join(', ')}")
    end
  end
end
