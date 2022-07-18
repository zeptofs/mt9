# frozen_string_literal: true

module MT9
  module Values
    RESERVED_BANK_CODES = %w[99].freeze

    DIRECT_CREDIT = "12"
    DIRECT_DEBIT = "20"
    FILE_TYPES = [DIRECT_CREDIT, DIRECT_DEBIT].freeze
    DETAIL_RECORD_TYPE = "13"
    TRAILER_KEY_FIELD = "99"
    DEBIT_TRANSACTION_CODES = %w[000].freeze
    CREDIT_TRANSACTION_CODES = %w[051 052].freeze
    ALL_TRANSACTION_CODES = (DEBIT_TRANSACTION_CODES | CREDIT_TRANSACTION_CODES).freeze

    MAX_AMOUNT = 9_999_999_999 # Due to detail record amount and trailer record total_amount only allowing 10 digits

    ALLOWED_ALPHANUMERIC_CHARS = /^[\w\(\+\$\*\!\)\;\-\/\?\:\'\"\=\&\<\>\.\,\%\_\#\@\ ]*$/.freeze
  end
end
