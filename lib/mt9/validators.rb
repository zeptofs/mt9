# frozen_string_literal: true

require "dry-validation"

module MT9
  module Validators
    class HeaderRecordContract < Dry::Validation::Contract
      FILE_TYPES = [12, 20].freeze

      schema do
        required(:file_type).filled(:integer, included_in?: FILE_TYPES)
        required(:account_number).filled(:string)
        required(:due_date).filled(:date)
        optional(:client_short_name).value(:string, size?: 0..20)
      end

      rule(:account_number) do
        key.failure("must be 15 numeric characters") unless /^\d{15}$/.match(value)
      end
    end
  end
end
