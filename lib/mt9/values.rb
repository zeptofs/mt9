# frozen_string_literal: true

module MT9
  module Values
    RESERVED_BANK_CODES = %w[99].freeze

    DIRECT_CREDIT = "12"
    DIRECT_DEBIT = "20"
    FILE_TYPES = [DIRECT_CREDIT, DIRECT_DEBIT].freeze
    TRAILER_KEY_FIELD = "99"
    DEBIT_TRANSACTION_CODES = ["000"].freeze
    CREDIT_TRANSACTION_CODES = %w[051 052].freeze
    DETAIL_RECORD_TYPE = "13"

    MAX_AMOUNT = 9_999_999_999 # Due to detail record amount and trailer record total_amount only allowing 10 digits
  end
end
