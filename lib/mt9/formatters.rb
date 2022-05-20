# frozen_string_literal: true

module Fixy
  module Formatter
    module Numeric
      RESERVED_BANK_CODES = %w[99].freeze

      def format_numeric(input, length)
        input = input.to_s
        raise ArgumentError, "Invalid input (only digits are accepted)" unless input =~ /^\d+$/
        raise ArgumentError, "Invalid length (length must be #{length})" if input.length != length

        input
      end

      def format_file_type(input, _length)
        input = input.to_s
        unless MT9::HeaderRecord::FILE_TYPES.include?(input)
          raise(
            ArgumentError,
            "Invalid filetype. Must be one of the following: #{MT9::HeaderRecord::FILE_TYPES.join(', ')}"
          )
        end

        input
      end

      def format_account_number(input, length)
        input = format_numeric(input, length)
        if input.start_with?(*RESERVED_BANK_CODES)
          raise ArgumentError, "Invalid account number. Cannot start with a reserved bank code"
        end

        input
      end
    end
  end
end
