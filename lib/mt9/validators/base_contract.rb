# frozen_string_literal: true

module MT9
  module Validators
    class BaseContract < Dry::Validation::Contract
      register_macro(:is_account_number?) do
        key.failure("must be 15 or 16 numeric characters") unless /^\d{15,16}$/.match(value)
        key.failure("must not start with a reserved bank code") if value.start_with?(*MT9::Values::RESERVED_BANK_CODES)
      end
    end
  end
end
