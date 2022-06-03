# frozen_string_literal: true

module MT9
  class Batch < Fixy::Document
    attr_reader :header_record, :detail_records, :hash_total, :total_amount

    def initialize(**kwargs)
      kwargs[:file_type] = file_type

      @header_record = HeaderRecord.new(kwargs)
      @detail_records = []
      @hash_total = 0
      @total_amount = 0

      yield self if block_given?
    end

    def add_transaction(**kwargs)
      transaction_args = build_transaction_args(kwargs)

      unless valid_transaction_code?(transaction_args[:transaction_code])
        raise ArgumentError, "Invalid transaction code"
      end

      if transaction_args[:amount] + total_amount > MT9::Values::MAX_AMOUNT
        raise RunTimeError "Batch total amount exceeds max amount: #{MT9::Values::MAX_AMOUNT} cents"
      end

      detail_record = DetailRecord.new(transaction_args)

      @total_amount += transaction_args[:amount]

      # Hash total is sum of branch and unique number components of account number
      @hash_total += Integer(transaction_args[:account_number][2..12])

      @detail_records << detail_record
    end

    def build
      append_record(header_record)
      detail_records.each { |record| append_record(record) }
      append_record(trailer_record)
    end

    def trailer_record
      TrailerRecord.new(hash_total: hash_total, total_amount: total_amount)
    end

    private

    # Shallow merge given hash with default transaction args
    def build_transaction_args(hash)
      default_transaction_args.merge(hash) do |_, a_val, b_val|
        if a_val.is_a?(Hash) && b_val.is_a?(Hash)
          a_val.merge(b_val)
        else
          b_val
        end
      end
    end

    def default_transaction_args
      {
        transaction_code: default_transaction_code,
        other_party: {
          name: header_record.client_short_name,
        },
      }
    end

    def default_transaction_code
      raise NotImplementedError
    end

    def file_type
      raise NotImplementedError
    end

    def valid_transaction_code?(transaction_code)
      raise NotImplementedError
    end
  end
end
