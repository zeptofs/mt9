# frozen_string_literal: true

module MT9
  module Validators
    class TrailerRecordContract < BaseContract
      schema do
        optional(:hash_total).value(:integer)
        required(:total_amount).value(:integer)
      end

      # TODO[T1][NZ] Figure out how small a hash_total should be formatted
      # rule(:hash_total) do
      #   key.failure("must have atleast 11 digits") if value.digits.size < 11
      # end

      rule(:total_amount) do
        key.failure("must not have more than 12 digits") if value.digits.size > 12
      end
    end
  end
end
