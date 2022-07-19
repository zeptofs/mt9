# frozen_string_literal: true

module MT9
  module Validators
    class HeaderRecordContract < BaseContract
      schema do
        required(:file_type).filled(:string, included_in?: Values::FILE_TYPES)
        required(:account_number).filled(:string, size?: 15) # Only 2 digit suffix allowed
        required(:due_date).filled(:date)
        optional(:client_short_name).maybe(:string, max_size?: 20)
      end

      rule(:account_number).validate(:is_account_number?)
      rule(:client_short_name).validate(:only_valid_characters?)
    end
  end
end
