# frozen_string_literal: true

module MT9
  module Values
    ALL_TRANSACTION_CODES = (DEBIT_TRANSACTION_CODES | CREDIT_TRANSACTION_CODES).freeze
    CREDIT_TRANSACTION_CODES = %w[051 052].freeze
    DEBIT_TRANSACTION_CODES = %w[000].freeze

    DIRECT_CREDIT = "12"
    DIRECT_DEBIT = "20"
    FILE_TYPES = [DIRECT_CREDIT, DIRECT_DEBIT].freeze

    ALLOWED_ALPHANUMERIC_CHARS = /^[\w\(\+\$\*\!\)\;\-\/\?\:\'\"\=\&\<\>\.\,\%\_\#\@\ ]*$/.freeze
    DETAIL_FIELD_MAX_LENGTH = 12
    DETAIL_RECORD_TYPE = "13"
    MAX_AMOUNT = 9_999_999_999 # Due to detail record amount and trailer record total_amount only allowing 10 digits
    NAME_MAX_LENGTH = 20
    RESERVED_BANK_CODES = %w[99].freeze
    TRAILER_KEY_FIELD = "99"
  end
end
