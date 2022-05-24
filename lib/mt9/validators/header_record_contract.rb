# frozen_string_literal: true

module MT9
  module Validators
    class HeaderRecordContract < Dry::Validation::Contract
      RESERVED_BANK_CODES = %w[99].freeze

      DIRECT_CREDIT = "12"
      DIRECT_DEBIT = "20"
      FILE_TYPES = [DIRECT_CREDIT, DIRECT_DEBIT].freeze

      schema do
        required(:file_type).filled(:string, included_in?: FILE_TYPES)
        required(:account_number).filled(:string)
        required(:due_date).filled(:string)
        optional(:client_short_name).value(:string, size?: 0..20)
      end

      rule(:account_number) do
        key.failure("must be 15 or 16 numeric characters") unless /^(\d{15}|\d{16})$/.match(value)
        key.failure("must not start with a reserved bank code") if value.start_with?(*RESERVED_BANK_CODES)
      end

      rule(:due_date) do
        key.failure("must be 6 or 8 numeric characters") unless /^(\d{6}|\d{8})$/.match(value)
      end
    end
  end
end
