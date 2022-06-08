# frozen_string_literal: true

module MT9
  module Validators
    class TrailerRecordContract < BaseContract
      schema do
        optional(:hash_total).value(:integer, gt?: 0)
        required(:total_amount).value(:integer, lteq?: Values::MAX_AMOUNT, gt?: 0)
      end
    end
  end
end
