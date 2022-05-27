# frozen_string_literal: true

module MT9
  module Validators
    class HeaderRecordContract < BaseContract
      schema do
        required(:file_type).filled(:string, included_in?: MT9::Values::FILE_TYPES)
        required(:account_number).filled(:string)
        required(:due_date).filled(:date)
        optional(:client_short_name).value(:string, size?: 0..20)
      end

      rule(:account_number).validate(:is_account_number?)
    end
  end
end
