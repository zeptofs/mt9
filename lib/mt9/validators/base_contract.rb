# frozen_string_literal: true

module MT9
  module Validators
    class BaseContract < Dry::Validation::Contract
      ALLOWED_ALPHANUMERIC_CHARS = /^[\w\(\+\$\*\!\)\;\-\/\?\:\'\"\=\&\<\>\.\,\%\_\#\@\ ]*$/.freeze

      register_macro(:is_account_number?) do
        key.failure("must be 15 or 16 numeric characters") unless value =~ /^\d{15,16}$/
        key.failure("must not start with a reserved bank code") if value.start_with?(*MT9::Values::RESERVED_BANK_CODES)
      end

      register_macro(:only_valid_characters?) do
        key.failure("must not contain invalid characters") unless value.nil? || value =~ ALLOWED_ALPHANUMERIC_CHARS
      end
    end
  end
end
