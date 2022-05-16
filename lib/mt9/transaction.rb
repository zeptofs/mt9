# encoding: UTF-8

module Mt9
  class Transaction
    # Usage Example
    #
    # t = Mt9::Transaction.new(
    #   account_bank_number: "123",
    #   account_branch_number: "123",
    # )
    #
    # batch = Mt9.batch(...)
    # batch.add_transaction t
    # batch.to_s

    DEBIT_TRANSACTION_CODES = ["000"]
    CREDIT_TRANSACTION_CODES = ["051", "052"]

    attr_accessor :account_bank_number, :account_branch_number, :account_unique_number, :account_suffix,
      :this_party_name, :this_party_reference, :this_party_code, :this_party_alpha_reference,

    def initialize(attrs = {})
      attrs.each do |key, value|
        send("#{key}=", value)
      end
    end

    def to_s
      # Record type
      output = "13"

      # Bank Number
      output += account_bank_number.to_s.rjust(2, " ")

      # Branch Number
      output += account_branch_number.to_s.rjust(4, " ")

      # Unique Number
      output += account_unique_number.to_s.rjust(7, " ")

      # Suffix
      output += account_suffix.to_s.ljust(3, " ")

      # Transaction Code
      output += account_suffix.to_s.rjust(3, "0")

      # This Party Name
      output += this_party_name.to_s.rjust(20, " ")

      # This Party Reference
      output += this_party_reference.to_s.ljust(12, "0")

      # This Party Code
      output += this_party_code.to_s.rjust(12, " ")

      # This Party Code
      output += this_party_code.to_s.rjust(12, " ")
      
      [output]
    end
  end
end
