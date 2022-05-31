# frozen_string_literal: true

module MT9
  module Validators
    class TrailerRecordContract < BaseContract
      schema do
        optional(:hash_total).value(:integer)
        required(:total_amount).value(:integer)
      end

      rule(:total_amount) do
        key.failure("must not have more than 12 digits") if value.digits.size > 12
      end
    end
  end
end
