# frozen_string_literal: true

module MT9
  module Values
    RESERVED_BANK_CODES = %w[99].freeze

    DIRECT_CREDIT = "12"
    DIRECT_DEBIT = "20"
    FILE_TYPES = [DIRECT_CREDIT, DIRECT_DEBIT].freeze
  end
end
