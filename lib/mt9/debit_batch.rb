# frozen_string_literal: true

module MT9
  class DebitBatch < Batch
    def file_type
      MT9::Values::DIRECT_DEBIT
    end

    def default_transaction_code
      MT9::Values::DEBIT_TRANSACTION_CODES.first
    end

    def valid_transaction_code?(transaction_code)
      MT9::Values::DEBIT_TRANSACTION_CODES.include?(transaction_code)
    end
  end
end
