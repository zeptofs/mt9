# frozen_string_literal: true

module MT9
  module Validators
    class BaseContract < Dry::Validation::Contract
      register_macro(:is_account_number?) do
        key.failure("must be 15 or 16 numeric characters") unless value =~ /^\d{15,16}$/
        key.failure("must not start with a reserved bank code") if value.start_with?(*Values::RESERVED_BANK_CODES)
      end

      register_macro(:only_valid_characters?) do
        unless value.nil? || value =~ Values::ALLOWED_CHARS_PATTERN
          key.failure("must not contain invalid characters")
        end
      end
    end
  end
end
