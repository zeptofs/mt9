# frozen_string_literal: true

module MT9
  module Validators
    class DetailRecordContract < BaseContract
      schema do
        required(:account_number).filled(:string, size?: 15..16)
        required(:transaction_code).filled(:string, included_in?: MT9::Values::ALL_TRANSACTION_CODES)
        required(:this_party).schema do
          required(:name).filled(:string, min_size?: 1)
          required(:code).filled(:string, min_size?: 1)
          required(:alpha_reference).filled(:string, min_size?: 1)
          required(:particulars).filled(:string, min_size?: 1)
        end
        required(:other_party).schema do
          required(:name).filled(:string, min_size?: 1)
          required(:code).filled(:string, min_size?: 1)
          required(:alpha_reference).filled(:string, min_size?: 1)
          required(:particulars).filled(:string, min_size?: 1)
        end
        required(:amount).filled(:integer, lt?: 10_000_000_000, gt?: 0)
      end

      rule(this_party: :name).validate(:only_valid_characters?)
      rule(this_party: :code).validate(:only_valid_characters?)
      rule(this_party: :alpha_reference).validate(:only_valid_characters?)
      rule(this_party: :particulars).validate(:only_valid_characters?)
      rule(other_party: :name).validate(:only_valid_characters?)
      rule(other_party: :code).validate(:only_valid_characters?)
      rule(other_party: :alpha_reference).validate(:only_valid_characters?)
      rule(other_party: :particulars).validate(:only_valid_characters?)
      rule(:account_number).validate(:is_account_number?)
    end
  end
end
