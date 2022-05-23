# frozen_string_literal: true

module Fixy
  module Formatter
    module Numeric
      RESERVED_BANK_CODES = %w[99].freeze

      DIRECT_CREDIT = "12"
      DIRECT_DEBIT = "20"
      FILE_TYPES = [DIRECT_CREDIT, DIRECT_DEBIT].freeze

      def format_numeric(input, length)
        input = input.to_s
        raise ArgumentError, "Invalid input (only digits are accepted)" unless input =~ /^\d+$/
        raise ArgumentError, "Invalid length (length must be #{length})" if input.length != length

        input
      end

      def format_file_type(input, _length)
        input = input.to_s
        unless FILE_TYPES.include?(input)
          raise(
            ArgumentError,
            "Invalid filetype. Must be one of the following: #{FILE_TYPES.join(', ')}"
          )
        end

        input
      end

      def format_account_number(input, length)
        raise ArgumentError, "Length of field needs to be 16" if length != 16

        input = input.to_s
        unless /^(\d{15}|\d{16})$/.match?(input)
          raise ArgumentError, "Invalid account number. Can only be 15 or 16 digits"
        end
        if input.start_with?(*RESERVED_BANK_CODES)
          raise ArgumentError, "Invalid account number. Cannot start with a reserved bank code"
        end

        input.ljust(length, " ")
      end
    end
  end
end
