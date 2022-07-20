# frozen_string_literal: true

module MT9
  module Validators
    class DetailRecordContract < BaseContract
      schema do
        required(:account_number).filled(:string)
        required(:transaction_code).filled(:string, included_in?: Values::ALL_TRANSACTION_CODES)
        required(:this_party).schema do
          required(:name).filled(:string, max_size?: Values::NAME_MAX_LENGTH)
          required(:code).filled(:string, max_size?: Values::DETAIL_FIELD_MAX_LENGTH)
          optional(:alpha_reference).maybe(:string, max_size?: Values::DETAIL_FIELD_MAX_LENGTH)
          optional(:particulars).maybe(:string, max_size?: Values::DETAIL_FIELD_MAX_LENGTH)
        end
        required(:other_party).schema do
          required(:name).filled(:string, max_size?: Values::NAME_MAX_LENGTH)
          optional(:code).maybe(:string, max_size?: Values::DETAIL_FIELD_MAX_LENGTH)
          optional(:alpha_reference).maybe(:string, max_size?: Values::DETAIL_FIELD_MAX_LENGTH)
          optional(:particulars).maybe(:string, max_size?: Values::DETAIL_FIELD_MAX_LENGTH)
        end
        required(:amount).filled(:integer, lteq?: Values::MAX_AMOUNT, gt?: 0)
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
